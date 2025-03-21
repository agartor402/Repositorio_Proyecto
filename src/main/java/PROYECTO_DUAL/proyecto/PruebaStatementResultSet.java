package PROYECTO_DUAL.proyecto;

import java.sql.*;

public class PruebaStatementResultSet {

	public static void main(String args[]){
        Connection conn = null;
        Statement st = null;
        ResultSet rs = null;

        try {
            
            conn = DBUtils.getConnection();
            st = conn.createStatement();
            rs = st.executeQuery("SELECT REGION_NAME, COUNTRY_NAME "
                    + "FROM COUNTRIES C, REGIONS R "
                    + "WHERE C.REGION_ID = R.REGION_ID "
                    + "ORDER BY 1");   
            
            while(rs.next()) {
                String regionName = rs.getString("REGION_NAME");
                String countryName = rs.getString("COUNTRY_NAME");
                System.out.println("RegionName = "+regionName+", countryName = "+countryName);
            }
            
        } catch(SQLException e) {
            System.out.println("Ocurrió algún error al conectar u operar con la BD");
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                
                if (st != null) {
                    st.close();
                }
                    
                DBUtils.close(conn);
            } catch(SQLException e) {
                System.out.println("Ocurrió una excepción al cerrar la BD");
            }
        }
    }
	
}
