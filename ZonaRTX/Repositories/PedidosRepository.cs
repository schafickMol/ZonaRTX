using Dapper;
using ZonaRTX.Models;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace ZonaRTX.data
{
    public class PedidosRepository : IBaseRepository<PedidosModel>
    {
        private readonly ISqlDataAccess _db;

        public PedidosRepository(ISqlDataAccess db)
        {
            _db = db;
        }

        public async Task<IEnumerable<PedidosModel>> GetAllAsync()
        {
            using var connection = _db.GetConnection();
            const string sql = "SELECT * FROM Pedidos";
            return await connection.QueryAsync<PedidosModel>(sql);
        }

        public async Task<PedidosModel> GetByIdAsync(int id)
        {
            using var connection = _db.GetConnection();
            const string sql = "SELECT * FROM Pedidos WHERE id_pedido = @id";
            return await connection.QueryFirstOrDefaultAsync<PedidosModel>(sql, new { id });
        }

        public async Task<int> InsertAsync(PedidosModel entity)
        {
            using var connection = _db.GetConnection();
            const string sql = @"INSERT INTO Pedidos (id_usuario, fecha_pedido, estado, total)
                                 VALUES (@id_usuario, @fecha_pedido, @estado, @total)";
            return await connection.ExecuteAsync(sql, entity);
        }

        public async Task<int> UpdateAsync(PedidosModel entity)
        {
            using var connection = _db.GetConnection();
            const string sql = @"UPDATE Pedidos
                                 SET id_usuario = @id_usuario,
                                     fecha_pedido = @fecha_pedido,
                                     estado = @estado,
                                     total = @total
                                 WHERE id_pedido = @id_pedido";
            return await connection.ExecuteAsync(sql, entity);
        }

        public async Task<int> DeleteAsync(int id)
        {
            using var connection = _db.GetConnection();
            const string sql = "DELETE FROM Pedidos WHERE id_pedido = @id";
            return await connection.ExecuteAsync(sql, new { id });
        }
    }
}
