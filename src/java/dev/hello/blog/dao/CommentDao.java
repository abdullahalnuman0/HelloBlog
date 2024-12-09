package dev.hello.blog.dao;

import dev.hello.blog.entities.Comment;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

public class CommentDao {

    Connection conn;

    public CommentDao(Connection conn) {
        this.conn = conn;
    }

    public ArrayList<Comment> getAllCommentByPostId(int pid) {

        ArrayList<Comment> comments = new ArrayList<>();

        try {

            Statement stmt = conn.createStatement();
            ResultSet set = stmt.executeQuery("SELECT * FROM comment WHERE posId = " + pid);

            while (set.next()) {
                comments.add(
                        new Comment(
                                set.getInt("cmnId"),
                                set.getString("cmnText"),
                                pid,
                                set.getInt("useId")
                        )
                );
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return comments;
    }

    public boolean insertComment(String comment, int pid, int uid) {

        try {

            String q = "INSERT INTO comment(cmnText, posId, useId) VALUES(?, ?, ?)";
            PreparedStatement pstmt = conn.prepareStatement(q);
            pstmt.setString(1, comment);
            pstmt.setInt(2, pid);
            pstmt.setInt(3, uid);

            pstmt.executeUpdate();

            return true;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;

    }

    public int countCommentOnPost(int pid) {

        try {

            String q = "SELECT count(*) FROM comment WHERE posId = ?";
            PreparedStatement pstmt = conn.prepareStatement(q);
            pstmt.setInt(1, pid);

            ResultSet set = pstmt.executeQuery();
            if (set.next()) {
                return set.getInt("count(*)");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return 0;
    }

    public boolean deleteComment(int pid, int uid) {

        try {

            String q = "DELETE FROM comment WHERE posId=? AND useId=?";

            PreparedStatement pstmt = conn.prepareStatement(q);
            pstmt.setInt(1, pid);
            pstmt.setInt(2, uid);

            pstmt.executeUpdate();

            return true;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

}
