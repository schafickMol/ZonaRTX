using System.Data;

namespace ZonaRTX.data
{
    public interface ISqlDataAccess
    {
        IDbConnection GetConnection();
    }
}