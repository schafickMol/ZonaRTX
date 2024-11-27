using Dapper;
using ZonaRTX.Models;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace ZonaRTX.data
{
    public class ProductosProveedoresRepository : IBaseRepository<ProductosProveedoresModel>
    {
        private readonly ISqlDataAccess _db;

        public ProductosProveedoresRepository(ISqlDataAccess db)
        {
            _db = db;
        }

        public async Task<IEnumerable<ProductosProveedoresModel>> GetAllAsync()
        {
            using var connection = _db.GetConnection();
            const string sql = "SELECT * FROM ProductosProveedores";
            return await connection.QueryAsync<ProductosProveedoresModel>(sql);
        }

        public async Task<ProductosProveedoresModel> GetByIdAsync(int id)
        {
            using var connection = _db.GetConnection();
            const string sql = "SELECT * FROM ProductosProveedores WHERE id_producto = @id";
            return await connection.QueryFirstOrDefaultAsync<ProductosProveedoresModel>(sql, new { id });
        }

        public async Task<int> InsertAsync(ProductosProveedoresModel entity)
        {
            using var connection = _db.GetConnection();
            const string sql = @"INSERT INTO ProductosProveedores (id_producto, id_proveedor, precio_compra)
                                 VALUES (@id_producto, @id_proveedor, @precio_compra)";
            return await connection.ExecuteAsync(sql, entity);
        }

        public async Task<int> UpdateAsync(ProductosProveedoresModel entity)
        {
            using var connection = _db.GetConnection();
            const string sql = @"UPDATE ProductosProveedores
                                 SET id_proveedor = @id_proveedor,
                                     precio_compra = @precio_compra
                                 WHERE id_producto = @id_producto";
            return await connection.ExecuteAsync(sql, entity);
        }

        public async Task<int> DeleteAsync(int id)
        {
            using var connection = _db.GetConnection();
            const string sql = "DELETE FROM ProductosProveedores WHERE id_producto = @id";
            return await connection.ExecuteAsync(sql, new { id });
        }
    }
}
