import java.sql.*;
import java.util.List;
import java.util.ArrayList;

public class Assignment3 extends JDBCSubmission {

    public Assignment3() throws ClassNotFoundException {
        System.out.println("Connecting to Database...");
        Class.forName("org.postgresql.Driver");
    }

    private Connection conn = null;
    private Statement stmt = null;

    @Override
    public boolean connectDB(String url, String username, String password) {


        try {
            conn = DriverManager.getConnection(url, username, password);
            
            stmt = conn.createStatement();

        } catch (SQLException se) {
            se.printStackTrace();
            return false;
        }
        return true;
    }

    @Override
    public boolean disconnectDB() {
	    try {
            if (stmt!=null) {
                stmt.close();
            }
            if (conn!=null) {
                conn.close();
            }
        } catch(SQLException se){
            se.printStackTrace();
            return false;
        } 
            return true;
    }

    @Override
    public ElectionResult presidentSequence(String countryName) {
        List<Integer> ids = ArrayList<Integer>();
        List<String> parties = ArrayList<String>();
        ElectionResult result = null;

        String = sql;

        sql = "SELECT C.name as country_name, pp.id as president_id, p.name as party_name" +
                "FROM politician_president PP JOIN country C ON PP.country_id = C.id" +
                "JOIN party P ON PP.party_id = P.id WHERE C.name = " + countryName;
        try {
            ResultSet rs = stmt.executeQuery(sql); 
            while (rs.next()) {
                ids.add(rs.getInt("president_id"));
                parties.add(rs.getString("party_name"));
                System.out.println("President id: " +ids.add(rs.getInt("president_id")));
                System.out.println("Party name: " +parties.add(rs.getString("party_name")));
            }

            result = ElectionResult(ids, parties);
        } catch(SQLException se) {
            se.printStackTrace();
            return null;
        } catch(Exceptio e) {
            e.printStackTrace();
            return null;
        }

        return result;
	}

    @Override
    public List<Integer> findSimilarParties(Integer partyId, Float threshold) {
	//Write your code here.
        return null;
    }

    public static void main(String[] args) throws Exception {
   	    //Write code here. 
	    System.out.println("Hellow World");
    }

}



