using Microsoft.AspNetCore.Mvc;
using System.Threading.Tasks;
using ZonaRTX.Models;
using ZonaRTX.data;

namespace ZonaRTX.Controllers
{
    public class ProductosController : Controller
    {
        private readonly IProductosRepository _repository;

        public ProductosController(IProductosRepository repository)
        {
            _repository = repository;
        }


        public async Task<IActionResult> Index()
        {
            var productos = await _repository.GetAllAsync();
            return View(productos);
        }

        public async Task<IActionResult> Details(int id)
        {
            var producto = await _repository.GetByIdAsync(id);
            if (producto == null)
            {
                return NotFound();
            }
            return View(producto);
        }

        public IActionResult Create()
        {
            return View();
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create(ProductosModel model)
        {
            // Validar que la categoría existe antes de insertar
            if (!await _repository.CategoriaExisteAsync(model.id_categoria))
            {
                ModelState.AddModelError("id_categoria", "La categoría no existe.");
                return View(model); // Retorna la vista con el error si la categoría no es válida
            }

            // Validar el modelo antes de proceder
            if (ModelState.IsValid)
            {
                // Establecer valores predeterminados
                model.fecha_agregado = DateTime.Now;

                // Insertar el producto en la base de datos
                await _repository.InsertAsync(model);

                // Redirigir al índice después de la inserción exitosa
                return RedirectToAction(nameof(Index));
            }

            // Si hay errores en el modelo, retornar la vista
            return View(model);
        }


        public async Task<IActionResult> Edit(int id)
        {
            var producto = await _repository.GetByIdAsync(id);
            if (producto == null)
            {
                return NotFound();
            }
            return View(producto);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(ProductosModel model)
        {
            if (ModelState.IsValid)
            {
                await _repository.UpdateAsync(model);
                return RedirectToAction(nameof(Index));
            }
            return View(model);
        }

        public async Task<IActionResult> Delete(int id)
        {
            var producto = await _repository.GetByIdAsync(id);
            if (producto == null)
            {
                return NotFound();
            }
            return View(producto);
        }

        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteConfirmed(int id)
        {
            await _repository.DeleteAsync(id);
            return RedirectToAction(nameof(Index));
        }
    }
}
