package dev.hello.blog.helper;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ConnectionProvider {

    private static Connection conn;

    public static Connection getConnection() {

        try {

            if (conn == null) {

                // Load driver
                Class.forName("com.mysql.cj.jdbc.Driver");

                // Create a Connection
                conn = DriverManager.getConnection(
                        "jdbc:mysql://localhost:3306/helloblog",
                        "root",
                        "Ab!dullah1"
                );

            }

        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }

        return conn;
    }

}
