import java.util.List;
import java.util.Set;

public class run extends Assignment3{

    public run() throws ClassNotFoundException {
        System.out.println("Connecting to Database...");
        Class.forName("org.postgresql.Driver");
    }

    public static void main(String[] args) throws Exception{
        Assignment3 tryI = new Assignment3();

        if ( !tryI.connectDB("dbsrv1.teach.cs.toronto.edu", "liuhao22", "Idoknowu!") ) {
            System.out.println("Error connecting DB.");
        }
        else {
            tryI.presidentSequence("Germany");
            Float ss = new Float(0.5);
            List<Integer> result = tryI.findSimilarParties(37, ss);
        }
    }
}