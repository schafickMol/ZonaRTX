using Dapper;
using ZonaRTX.data;
using ZonaRTX.Models;
using System;
using System.Collections.Generic;
using System.Data;
using System.Threading.Tasks;

public class ProductosRepository : BaseRepository<ProductosModel>, IProductosRepository
{
    private readonly ISqlDataAccess _db;

    public ProductosRepository(ISqlDataAccess db) : base(db)
    {
        _db = db;
    }
    // Método para obtener todos los productos
    public async Task<IEnumerable<ProductosModel>> GetAllAsync()
    {
        using var connection = _db.GetConnection();
        const string sql = "SELECT * FROM Productos";
        return await connection.QueryAsync<ProductosModel>(sql);
    }

    // Método para obtener un producto por su ID
    public async Task<ProductosModel> GetByIdAsync(int id)
    {
        using var connection = _db.GetConnection();
        const string sql = "SELECT * FROM Productos WHERE id_producto = @id";
        return await connection.QueryFirstOrDefaultAsync<ProductosModel>(sql, new { id });
    }

    // Método para insertar un nuevo producto
    public async Task<int> InsertAsync(ProductosModel entity)
    {
        try
        {
            using var connection = _db.GetConnection();
            const string sql = @"
                INSERT INTO Productos (nombre_producto, descripcion, precio, id_categoria)
                VALUES (@nombre_producto, @descripcion, @precio, @id_categoria)";
            return await connection.ExecuteAsync(sql, entity);
        }
        catch (Exception ex)
        {
            Console.WriteLine($"Error al insertar el producto: {ex.Message}");
            throw; // Lanza la excepción para propagar el error
        }
    }

    // Método para actualizar un producto existente
    public async Task<int> UpdateAsync(ProductosModel entity)
    {
        using var connection = _db.GetConnection();
        const string sql = @"
            UPDATE Productos
            SET nombre_producto = @nombre_producto,
                descripcion = @descripcion,
                precio = @precio,
                id_categoria = @id_categoria,
                fecha_agregado = @fecha_agregado
            WHERE id_producto = @id_producto";
        return await connection.ExecuteAsync(sql, entity);
    }

    // Método para eliminar un producto por su ID
    public async Task<int> DeleteAsync(int id)
    {
        using var connection = _db.GetConnection();
        const string sql = "DELETE FROM Productos WHERE id_producto = @id";
        return await connection.ExecuteAsync(sql, new { id });
    }

    // Método para validar si una categoría existe antes de agregar o actualizar un producto
    public async Task<bool> CategoriaExisteAsync(int idCategoria)
    {
        var query = "SELECT COUNT(1) FROM Categorias WHERE id_categoria = @IdCategoria";
        using (var connection = _db.GetConnection())
        {
            return await connection.ExecuteScalarAsync<bool>(query, new { IdCategoria = idCategoria });
        }
    }

}
