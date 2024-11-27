using Dapper;
using ZonaRTX.Models;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace ZonaRTX.data
{
    public class CategoriasRepository : IBaseRepository<CategoriasModel>
    {
        private readonly ISqlDataAccess _db;

        public CategoriasRepository(ISqlDataAccess db)
        {
            _db = db;
        }

        public async Task<IEnumerable<CategoriasModel>> GetAllAsync()
        {
            using var connection = _db.GetConnection();
            const string sql = "SELECT * FROM Categorias";  
            return await connection.QueryAsync<CategoriasModel>(sql);
        }


        public async Task<CategoriasModel> GetByIdAsync(int id)
        {
            using var connection = _db.GetConnection();
            const string sql = "SELECT * FROM Categorias WHERE id_categoria = @id";
            return await connection.QueryFirstOrDefaultAsync<CategoriasModel>(sql, new { id });
        }

        public async Task<int> InsertAsync(CategoriasModel entity)
        {
            using var connection = _db.GetConnection();
            const string sql = @"INSERT INTO Categorias (nombre_categoria, descripcion)
                                 VALUES (@nombre_categoria, @descripcion)";
            return await connection.ExecuteAsync(sql, entity);
        }

        public async Task<int> UpdateAsync(CategoriasModel entity)
        {
            using var connection = _db.GetConnection();
            const string sql = @"UPDATE Categorias
                                 SET nombre_categoria = @nombre_categoria,
                                     descripcion = @descripcion
                                 WHERE id_categoria = @id_categoria";
            return await connection.ExecuteAsync(sql, entity);
        }

        public async Task<int> DeleteAsync(int id)
        {
            using var connection = _db.GetConnection();
            const string sql = "DELETE FROM Categorias WHERE id_categoria = @id";
            return await connection.ExecuteAsync(sql, new { id });
        }
    }
}
