using Microsoft.AspNetCore.Mvc;
using System.Threading.Tasks;
using ZonaRTX.Models;
using ZonaRTX.data;

namespace ZonaRTX.Controllers
{
    public class DetallesPedidosController : Controller
    {
        private readonly IBaseRepository<DetallesPedidosModel> _repository;
        private readonly IBaseRepository<ProductosModel> _productoRepository;

        public DetallesPedidosController(
            IBaseRepository<DetallesPedidosModel> repository,
            IBaseRepository<ProductosModel> productoRepository)
        {
            _repository = repository;
            _productoRepository = productoRepository;
        }


        public async Task<IActionResult> Index()
        {
            // Obtener todos los detalles de pedidos desde el repositorio
            var detallesPedidos = await _repository.GetAllAsync();

            // Pasar los detalles a la vista
            return View(detallesPedidos);
        }

        [HttpPost]
        public async Task<IActionResult> Eliminar(int id_detalle)
        {
            var result = await _repository.DeleteAsync(id_detalle);
            if (result == 0)
            {
                return NotFound(); // Si no se eliminó ningún registro
            }
            return RedirectToAction("Index");
        }



        //[Route("comprar/{id_producto}")]
        //public async Task<IActionResult> Comprar(int id_producto)
        //{
        //    // Obtener detalles del producto
        //    var producto = await _productoRepository.GetByIdAsync(id_producto);
        //    if (producto == null)
        //    {
        //        return NotFound();
        //    }

        //    // Crear detalle de pedido
        //    var detallePedido = new DetallesPedidosModel
        //    {
        //        id_pedido = 1, // Debes manejar esto según tu lógica
        //        id_producto = producto.id_producto,
        //        cantidad = 1,
        //        precio_unitario = producto.precio,
        //    };

        //    // Guardar el detalle en la base de datos
        //    await _repository.InsertAsync(detallePedido);

        //    // Redirigir a Home o a una vista de confirmación
        //    return RedirectToAction("Index", "Home");
        //}
    }
}
