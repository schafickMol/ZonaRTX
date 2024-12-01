    using Microsoft.AspNetCore.Mvc;
    using System.Threading.Tasks;
    using ZonaRTX.Models;
    using ZonaRTX.data;

namespace ZonaRTX.Controllers
{
    public class CategoriasController : Controller
    {
        private readonly IBaseRepository<CategoriasModel> _repository;

        public CategoriasController(IBaseRepository<CategoriasModel> repository)
        {
            _repository = repository;
        }

        // Mostrar todas las categorías
        public async Task<IActionResult> Index()
        {
            var categorias = await _repository.GetAllAsync();
            return View(categorias);
        }

        // Mostrar detalles de una categoría específica
        public async Task<IActionResult> Details(int id)
        {
            var categoria = await _repository.GetByIdAsync(id);
            if (categoria == null)
            {
                return NotFound();
            }
            return View(categoria);
        }

        // Mostrar formulario para crear una nueva categoría
        public IActionResult Create()
        {
            return View();
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create(CategoriasModel model)
        {
            if (ModelState.IsValid)
            {
                // No es necesario asignar null a id_categoria
                await _repository.InsertAsync(model);
                return RedirectToAction(nameof(Index));
            }
            return View(model);
        }



        // Mostrar formulario para editar una categoría
        public async Task<IActionResult> Edit(int id)
        {
            var categoria = await _repository.GetByIdAsync(id);
            if (categoria == null)
            {
                return NotFound();
            }
            return View(categoria);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(CategoriasModel model)
        {
            if (ModelState.IsValid)
            {
                // Verifica que el ID sea válido
                if (model.id_categoria <= 0)
                {
                    return NotFound();
                }
                await _repository.UpdateAsync(model);
                return RedirectToAction(nameof(Index));
            }
            return View(model);
        }


        public async Task<IActionResult> Delete(int id)
        {
            var categoria = await _repository.GetByIdAsync(id);
            if (categoria == null)
            {
                return NotFound();
            }
            return View(categoria);
        }

        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteConfirmed(int id)
        {
            try
            {
                await _repository.DeleteAsync(id);
                return RedirectToAction(nameof(Index));
            }
            catch (Exception ex)
            {
                // Log el error y redirige a una página de error o muestra un mensaje en la misma vista.
                Console.WriteLine($"Error al eliminar la categoría: {ex.Message}");
                return View("Error", new ErrorViewModel { Message = "No se pudo eliminar la categoría." });
            }
        }
    }
}
