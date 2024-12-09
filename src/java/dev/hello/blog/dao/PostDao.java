package dev.hello.blog.dao;

import dev.hello.blog.entities.Categorie;
import dev.hello.blog.entities.Post;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class PostDao {

    private Connection conn;

    public PostDao(Connection conn) {
        this.conn = conn;
    }

    public ArrayList<Categorie> getAllCategories() {

        ArrayList<Categorie> list = new ArrayList<>();

        try {

            String q = "SELECT * FROM categories";

            Statement stmt = conn.createStatement();
            ResultSet set = stmt.executeQuery(q);

            while (set.next()) {
                list.add(
                        new Categorie(
                                set.getInt("cid"),
                                set.getString("name"),
                                set.getString("description")
                        )
                );
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;

    }

    public boolean savePost(Post post) {

        try {

            String q = "INSERT INTO posts(pTitle,pContent,pCode,pPic,catId,userID) "
                    + "VALUES(?,?,?,?,?,?)";

            PreparedStatement pstmt = conn.prepareStatement(q);
            pstmt.setString(1, post.getpTitle());
            pstmt.setString(2, post.getpContent());
            pstmt.setString(3, post.getpCode());
            pstmt.setString(4, post.getpPic());
            pstmt.setInt(5, post.getCatId());
            pstmt.setInt(6, post.getUserId());

            pstmt.executeUpdate();

            return true;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    public List<Post> getAllPosts() {
        List<Post> list = new ArrayList<>();

        // fetch all teh post
        try {

            PreparedStatement pstmt = conn.prepareStatement("SELECT * FROM posts ORDER BY pid DESC");

            ResultSet set = pstmt.executeQuery();

            while (set.next()) {
                list.add(
                        new Post(
                                set.getInt("pid"),
                                set.getString("pTitle"),
                                set.getString("pContent"),
                                set.getString("pCode"),
                                set.getString("pPic"),
                                set.getTimestamp("pDate"),
                                set.getInt("catId"),
                                set.getInt("userID")
                        )
                );
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public List<Post> getPostsCatId(int catId) {
        List<Post> list = new ArrayList<>();

        // fetch all post by id
        try {

            PreparedStatement pstmt = conn.prepareStatement("SELECT * FROM posts WHERE catId = ? ORDER BY pid DESC");
            pstmt.setInt(1, catId);

            ResultSet set = pstmt.executeQuery();

            while (set.next()) {
                list.add(
                        new Post(
                                set.getInt("pid"),
                                set.getString("pTitle"),
                                set.getString("pContent"),
                                set.getString("pCode"),
                                set.getString("pPic"),
                                set.getTimestamp("pDate"),
                                catId,
                                set.getInt("userID")
                        )
                );
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

       
    
    public List<Post> getAllPostsByUserId(int userID) {
        List<Post> list = new ArrayList<>();

        // fetch all post by id
        try {

            PreparedStatement pstmt = conn.prepareStatement("SELECT * FROM posts WHERE userID = ? ORDER BY pid DESC");
            pstmt.setInt(1, userID);

            ResultSet set = pstmt.executeQuery();

            while (set.next()) {
                list.add(
                        new Post(
                                set.getInt("pid"),
                                set.getString("pTitle"),
                                set.getString("pContent"),
                                set.getString("pCode"),
                                set.getString("pPic"),
                                set.getTimestamp("pDate"),
                                set.getInt("catId"),
                                userID
                        )
                );
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    
    
    
    public Post getPostsByPostID(int postId) {

        // fetch all post by id
        try {

            PreparedStatement pstmt = conn.prepareStatement("SELECT * FROM posts WHERE pid = ?");
            pstmt.setInt(1, postId);

            ResultSet set = pstmt.executeQuery();

            if (set.next()) {

                return new Post(
                        postId,
                        set.getString("pTitle"),
                        set.getString("pContent"),
                        set.getString("pCode"),
                        set.getString("pPic"),
                        set.getTimestamp("pDate"),
                        set.getInt("catId"),
                        set.getInt("userID")
                );

            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }
    
    
    
    public boolean deletePost(int pid) {

        try {

            String q = "DELETE FROM posts WHERE pid=?";

            PreparedStatement pstmt = conn.prepareStatement(q);
            pstmt.setInt(1, pid);

            pstmt.executeUpdate();

            return true;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }


}
