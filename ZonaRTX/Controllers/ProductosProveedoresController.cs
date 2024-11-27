using Microsoft.AspNetCore.Mvc;
using System.Threading.Tasks;
using ZonaRTX.Models;
using ZonaRTX.data;

namespace ZonaRTX.Controllers
{
    public class ProductosProveedoresController : Controller
    {
        private readonly IBaseRepository<ProductosProveedoresModel> _repository;

        public ProductosProveedoresController(IBaseRepository<ProductosProveedoresModel> repository)
        {
            _repository = repository;
        }

        public async Task<IActionResult> Index()
        {
            var productosProveedores = await _repository.GetAllAsync();
            return View(productosProveedores);
        }

        public async Task<IActionResult> Details(int id)
        {
            var productoProveedor = await _repository.GetByIdAsync(id);
            if (productoProveedor == null)
            {
                return NotFound();
            }
            return View(productoProveedor);
        }

        public IActionResult Create()
        {
            return View();
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create(ProductosProveedoresModel model)
        {
            if (ModelState.IsValid)
            {
                await _repository.InsertAsync(model);
                return RedirectToAction(nameof(Index));
            }
            return View(model);
        }

        public async Task<IActionResult> Edit(int id)
        {
            var productoProveedor = await _repository.GetByIdAsync(id);
            if (productoProveedor == null)
            {
                return NotFound();
            }
            return View(productoProveedor);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(ProductosProveedoresModel model)
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
            var productoProveedor = await _repository.GetByIdAsync(id);
            if (productoProveedor == null)
            {
                return NotFound();
            }
            return View(productoProveedor);
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
