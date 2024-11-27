using Microsoft.AspNetCore.Mvc;
using System.Threading.Tasks;
using ZonaRTX.Models;
using ZonaRTX.data;

namespace ZonaRTX.Controllers
{
    public class InventarioController : Controller
    {
        private readonly IBaseRepository<InventarioModel> _repository;

        public InventarioController(IBaseRepository<InventarioModel> repository)
        {
            _repository = repository;
        }

        public async Task<IActionResult> Index()
        {
            var inventario = await _repository.GetAllAsync();
            return View(inventario);
        }

        public async Task<IActionResult> Details(int id)
        {
            var item = await _repository.GetByIdAsync(id);
            if (item == null)
            {
                return NotFound();
            }
            return View(item);
        }

        public IActionResult Create()
        {
            return View();
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create(InventarioModel model)
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
            var item = await _repository.GetByIdAsync(id);
            if (item == null)
            {
                return NotFound();
            }
            return View(item);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(InventarioModel model)
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
            var item = await _repository.GetByIdAsync(id);
            if (item == null)
            {
                return NotFound();
            }
            return View(item);
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
