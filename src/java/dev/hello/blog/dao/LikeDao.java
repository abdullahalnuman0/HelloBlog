package dev.hello.blog.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class LikeDao {

    Connection conn;

    public LikeDao(Connection conn) {
        this.conn = conn;
    }

    public boolean insertLike(int pid, int uid) {

        try {

            String q = "INSERT INTO likes(pid,uid) VALUES(?,?)";
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

    public int countLikeOnPost(int pid) {

        try {

            String q = "SELECT count(*) FROM likes WHERE pid = ?";
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

    public boolean isLikedByUser(int pid, int uid) {

        try {

            String q = "SELECT * FROM likes WHERE pid = ? AND uid = ?";
            PreparedStatement pstmt = conn.prepareStatement(q);
            pstmt.setInt(1, pid);
            pstmt.setInt(2, uid);

            ResultSet set = pstmt.executeQuery();
            if (set.next()) {
                return true;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    public boolean deleteLike(int pid, int uid) {

        try {

            String q = "DELETE FROM likes WHERE pid=? AND uid=?";

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

    public String likeCss(int pid, int uid) {
        return isLikedByUser(pid, uid) ? "fa-thumbs-up" : "fa-thumbs-o-up";
    }

}
// likeDao.isLikedByUser() ?'':'fa-thumbs-up'
