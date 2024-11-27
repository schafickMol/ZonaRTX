using Dapper;
using ZonaRTX.Models;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace ZonaRTX.data
{
    public class ProveedoresRepositorio : IBaseRepository<ProveedoresModel>
    {
        private readonly ISqlDataAccess _db;

        public ProveedoresRepositorio(ISqlDataAccess db)
        {
            _db = db;
        }

        public async Task<IEnumerable<ProveedoresModel>> GetAllAsync()
        {
            using var connection = _db.GetConnection();
            const string sql = "SELECT * FROM Proveedores";
            return await connection.QueryAsync<ProveedoresModel>(sql);
        }

        public async Task<ProveedoresModel> GetByIdAsync(int id)
        {
            using var connection = _db.GetConnection();
            const string sql = "SELECT * FROM Proveedores WHERE id_proveedor = @id";
            return await connection.QueryFirstOrDefaultAsync<ProveedoresModel>(sql, new { id });
        }

        public async Task<int> InsertAsync(ProveedoresModel entity)
        {
            using var connection = _db.GetConnection();
            const string sql = @"INSERT INTO Proveedores (nombre, contacto, telefono, email)
                                 VALUES (@nombre, @contacto, @telefono, @email)";
            return await connection.ExecuteAsync(sql, entity);
        }

        public async Task<int> UpdateAsync(ProveedoresModel entity)
        {
            using var connection = _db.GetConnection();
            const string sql = @"UPDATE Proveedores
                                 SET nombre = @nombre,
                                     contacto = @contacto,
                                     telefono = @telefono,
                                     email = @email
                                 WHERE id_proveedor = @id_proveedor";
            return await connection.ExecuteAsync(sql, entity);
        }

        public async Task<int> DeleteAsync(int id)
        {
            using var connection = _db.GetConnection();
            const string sql = "DELETE FROM Proveedores WHERE id_proveedor = @id";
            return await connection.ExecuteAsync(sql, new { id });
        }
    }
}
