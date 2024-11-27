using Microsoft.AspNetCore.Mvc;
using System.Threading.Tasks;
using ZonaRTX.Models;
using ZonaRTX.data;

namespace ZonaRTX.Controllers
{
    public class DetallesPedidosController : Controller
    {
        private readonly IBaseRepository<DetallesPedidosModel> _repository;

        public DetallesPedidosController(IBaseRepository<DetallesPedidosModel> repository)
        {
            _repository = repository;
        }

        public async Task<IActionResult> Index()
        {
            var detallesPedidos = await _repository.GetAllAsync();
            return View(detallesPedidos);
        }

        public async Task<IActionResult> Details(int id)
        {
            var detallePedido = await _repository.GetByIdAsync(id);
            if (detallePedido == null)
            {
                return NotFound();
            }
            return View(detallePedido);
        }

        public IActionResult Create()
        {
            return View();
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create(DetallesPedidosModel model)
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
            var detallePedido = await _repository.GetByIdAsync(id);
            if (detallePedido == null)
            {
                return NotFound();
            }
            return View(detallePedido);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(DetallesPedidosModel model)
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
            var detallePedido = await _repository.GetByIdAsync(id);
            if (detallePedido == null)
            {
                return NotFound();
            }
            return View(detallePedido);
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
