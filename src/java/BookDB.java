
import java.io.FileInputStream;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Properties;
import java.io.InputStream;
import java.net.URLEncoder;

public class BookDB extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private static final Logger logger = Logger.getLogger(BookDB.class.getName());

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String url = "jdbc:mysql://localhost:3306/22r11a6218";
        String driver = "com.mysql.cj.jdbc.Driver";
        String user = "sairaj";
        String password = "sairaj8799";

        Connection con = null;
        PreparedStatement st = null;

        String query = "INSERT INTO Dakshayani (RoonNo, Cname, PhNo, CheckInDate, CheckOutDate) VALUES (?, ?, ?, ?, ?)";
        int flag = 0;

        String CName = request.getParameter("Cname");
        String PhoneNo = request.getParameter("PhNo");
        String RoomNo = request.getParameter("RNo");
        String checkin = request.getParameter("CheckinDate");
        String checkout = request.getParameter("checkoutDate");

        if (CName == null || PhoneNo == null || RoomNo == null || checkin == null || checkout == null
                || CName.isEmpty() || PhoneNo.isEmpty() || RoomNo.isEmpty() || checkin.isEmpty() || checkout.isEmpty()) {
            response.sendRedirect("BookingFailed.jsp?error=Missing+parameters" + CName.isEmpty() + "" + PhoneNo.isEmpty() + "" + RoomNo.isEmpty() + "" + checkin.isEmpty() + "" + checkout.isEmpty());
            return;
        }

        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        dateFormat.setLenient(false);

        java.sql.Date checkinSqlDate = null;
        java.sql.Date checkoutSqlDate = null;

        try {
            java.util.Date checkinUtilDate = dateFormat.parse(checkin);
            java.util.Date checkoutUtilDate = dateFormat.parse(checkout);
            checkinSqlDate = new java.sql.Date(checkinUtilDate.getTime());
            checkoutSqlDate = new java.sql.Date(checkoutUtilDate.getTime());
        } catch (ParseException e) {
            logger.log(Level.SEVERE, "Date parsing error", e);
            response.sendRedirect("BookingFailed.jsp?error=Invalid+date+format");
            return;
        }

        try {
            Class.forName(driver);
            con = DriverManager.getConnection(url, user, password);
            st = con.prepareStatement(query);
            st.setString(1, RoomNo);
            st.setString(2, CName);
            st.setString(3, PhoneNo);
            st.setDate(4, checkinSqlDate);
            st.setDate(5, checkoutSqlDate);
            flag = st.executeUpdate();
        } catch (ClassNotFoundException | SQLException e) {
            logger.log(Level.SEVERE, "Error executing SQL query", e);
            response.sendRedirect("BookingFailed.jsp?error=Database+error");
            return;
        } finally {
            try {
                if (st != null) {
                    st.close();
                }
                if (con != null) {
                    con.close();
                }
            } catch (SQLException ex) {
                logger.log(Level.SEVERE, "Error closing resources", ex);
            }
        }

        if (flag != 0) {
            response.sendRedirect("Succes.jsp?Cname=" + URLEncoder.encode(CName, "UTF-8") + "&RNo=" + URLEncoder.encode(RoomNo, "UTF-8"));
        } else {
            response.sendRedirect("BookingFailed.jsp?error=Booking+failed");
        }
    }
}
