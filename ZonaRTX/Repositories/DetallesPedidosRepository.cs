using Dapper;
using ZonaRTX.Models;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace ZonaRTX.data
{
    public class DetallesPedidosRepository : IBaseRepository<DetallesPedidosModel>
    {
        private readonly ISqlDataAccess _db;

        public DetallesPedidosRepository(ISqlDataAccess db)
        {
            _db = db;
        }

        public async Task<IEnumerable<DetallesPedidosModel>> GetAllAsync()
        {
            using var connection = _db.GetConnection();
            const string sql = "SELECT * FROM DetallesPedidos";
            return await connection.QueryAsync<DetallesPedidosModel>(sql);
        }

        public async Task<DetallesPedidosModel> GetByIdAsync(int id)
        {
            using var connection = _db.GetConnection();
            const string sql = "SELECT * FROM DetallesPedidos WHERE id_detalle = @id";
            return await connection.QueryFirstOrDefaultAsync<DetallesPedidosModel>(sql, new { id });
        }

        public async Task<int> InsertAsync(DetallesPedidosModel entity)
        {
            using var connection = _db.GetConnection();
            const string sql = @"INSERT INTO DetallesPedidos (id_pedido, id_producto, cantidad, precio_unitario)
                                 VALUES (@id_pedido, @id_producto, @cantidad, @precio_unitario)";
            return await connection.ExecuteAsync(sql, entity);
        }

        public async Task<int> UpdateAsync(DetallesPedidosModel entity)
        {
            using var connection = _db.GetConnection();
            const string sql = @"UPDATE DetallesPedidos
                                 SET id_pedido = @id_pedido,
                                     id_producto = @id_producto,
                                     cantidad = @cantidad,
                                     precio_unitario = @precio_unitario
                                 WHERE id_detalle = @id_detalle";
            return await connection.ExecuteAsync(sql, entity);
        }

        public async Task<int> DeleteAsync(int id)
        {
            using var connection = _db.GetConnection();
            const string sql = "DELETE FROM DetallesPedidos WHERE id_detalle = @id";
            return await connection.ExecuteAsync(sql, new { id });
        }
    }
}
