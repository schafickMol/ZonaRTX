using Dapper;
using ZonaRTX.Models;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace ZonaRTX.data
{
    public class InventarioRepository : IBaseRepository<InventarioModel>
    {
        private readonly ISqlDataAccess _db;

        public InventarioRepository(ISqlDataAccess db)
        {
            _db = db;
        }

        public async Task<IEnumerable<InventarioModel>> GetAllAsync()
        {
            using var connection = _db.GetConnection();
            const string sql = "SELECT * FROM Inventario";
            return await connection.QueryAsync<InventarioModel>(sql);
        }

        public async Task<InventarioModel> GetByIdAsync(int id)
        {
            using var connection = _db.GetConnection();
            const string sql = "SELECT * FROM Inventario WHERE id_pedido = @id";
            return await connection.QueryFirstOrDefaultAsync<InventarioModel>(sql, new { id });
        }

        public async Task<int> InsertAsync(InventarioModel entity)
        {
            using var connection = _db.GetConnection();
            const string sql = @"INSERT INTO Inventario (id_usuario, fecha_pedido, estado)
                                 VALUES (@id_usuario, @fecha_pedido, @estado)";
            return await connection.ExecuteAsync(sql, entity);
        }

        public async Task<int> UpdateAsync(InventarioModel entity)
        {
            using var connection = _db.GetConnection();
            const string sql = @"UPDATE Inventario
                                 SET id_usuario = @id_usuario,
                                     fecha_pedido = @fecha_pedido,
                                     estado = @estado
                                 WHERE id_pedido = @id_pedido";
            return await connection.ExecuteAsync(sql, entity);
        }

        public async Task<int> DeleteAsync(int id)
        {
            using var connection = _db.GetConnection();
            const string sql = "DELETE FROM Inventario WHERE id_pedido = @id";
            return await connection.ExecuteAsync(sql, new { id });
        }
    }
}
