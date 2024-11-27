using Dapper;
using ZonaRTX.Models;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace ZonaRTX.data
{
    public class UsuariosRepository : IBaseRepository<UsuariosModel>
    {
        private readonly ISqlDataAccess _db;

        public UsuariosRepository(ISqlDataAccess db)
        {
            _db = db;
        }

        public async Task<IEnumerable<UsuariosModel>> GetAllAsync()
        {
            using var connection = _db.GetConnection();
            const string sql = "SELECT * FROM Usuarios";
            return await connection.QueryAsync<UsuariosModel>(sql);
        }

        public async Task<UsuariosModel> GetByIdAsync(int id)
        {
            using var connection = _db.GetConnection();
            const string sql = "SELECT * FROM Usuarios WHERE id_usuario = @id";
            return await connection.QueryFirstOrDefaultAsync<UsuariosModel>(sql, new { id });
        }

        public async Task<int> InsertAsync(UsuariosModel entity)
        {
            using var connection = _db.GetConnection();
            const string sql = @"INSERT INTO Usuarios (nombre, apellido, email, contrasena)
                                 VALUES (@nombre, @apellido, @email, @contrasena)";
            return await connection.ExecuteAsync(sql, entity);
        }

        public async Task<int> UpdateAsync(UsuariosModel entity)
        {
            using var connection = _db.GetConnection();
            const string sql = @"UPDATE Usuarios
                                 SET nombre = @nombre,
                                     apellido = @apellido,
                                     email = @email,
                                     contrasena = @contrasena
                                 WHERE id_usuario = @id_usuario";
            return await connection.ExecuteAsync(sql, entity);
        }

        public async Task<int> DeleteAsync(int id)
        {
            using var connection = _db.GetConnection();
            const string sql = "DELETE FROM Usuarios WHERE id_usuario = @id";
            return await connection.ExecuteAsync(sql, new { id });
        }
    }
}
