using Dapper;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using ZonaRTX.data;
using ZonaRTX.Models;

namespace ZonaRTX.Controllers
{
    public class CompraController : Controller
    {
        private readonly IBaseRepository<DetallesPedidosModel> _repository;
        private readonly IBaseRepository<ProductosModel> _productoRepository;
        private readonly ISqlDataAccess _db;  // Agregar la dependencia para la conexión

        public CompraController(
            IBaseRepository<DetallesPedidosModel> repository,
            IBaseRepository<ProductosModel> productoRepository,
            ISqlDataAccess db) // Inyectar la dependencia de ISqlDataAccess
        {
            _repository = repository;
            _productoRepository = productoRepository;
            _db = db; // Asignar la conexión
        }

        public async Task<IActionResult> Comprar(int id_producto)
        {
            // Obtener detalles del producto
            var producto = await _productoRepository.GetByIdAsync(id_producto);
            if (producto == null)
            {
                return NotFound();
            }

            // Obtener el id del pedido del usuario (puede ser dinámico, como desde la sesión)
            int id_pedido = 1; // Cambia esto según tu lógica

            using var connection = _db.GetConnection();
            const string sqlCheck = @"SELECT * FROM DetallePedidos 
                              WHERE id_pedido = @id_pedido AND id_producto = @id_producto";
            var detalleExistente = await connection.QueryFirstOrDefaultAsync<DetallesPedidosModel>(
                sqlCheck, new { id_pedido, id_producto });

            if (detalleExistente != null)
            {
                // Si ya existe, incrementa la cantidad y recalcula el subtotal
                const string sqlUpdate = @"UPDATE DetallePedidos 
                                   SET cantidad = cantidad + 1
                                   WHERE id_pedido = @id_pedido AND id_producto = @id_producto";
                await connection.ExecuteAsync(sqlUpdate, new { id_pedido, id_producto });
            }
            else
            {
                // Si no existe, crea un nuevo registro
                var detallePedido = new DetallesPedidosModel
                {
                    id_pedido = id_pedido,
                    id_producto = producto.id_producto,
                    cantidad = 1,
                    precio_unitario = producto.precio,
                };

                await _repository.InsertAsync(detallePedido);
            }

            return RedirectToAction("Index", "DetallesPedidos");
        }

    }
}