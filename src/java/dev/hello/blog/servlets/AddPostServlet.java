package dev.hello.blog.servlets;

import dev.hello.blog.dao.PostDao;
import dev.hello.blog.entities.Post;
import dev.hello.blog.entities.User;
import dev.hello.blog.helper.ConnectionProvider;
import dev.hello.blog.helper.Helper;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.File;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Random;

@MultipartConfig
public class AddPostServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {

            int cid = Integer.parseInt(request.getParameter("cid"));
            String pTitle = request.getParameter("pTitle");
            String pContent = request.getParameter("pContent");
            String pCode = request.getParameter("pCode");

//            Part part = request.getPart("pPic");
            ArrayList<Part> allImage = Helper.getAllImage(request.getParts(), "pPic");

            String[] allImageName = Helper.getAllImageName(allImage);
            String pPic = Helper.getFilesName(allImageName);
       
            //Getting post user---
            HttpSession session = request.getSession();
            User user = (User) session.getAttribute("currentUser");
            int userId = user.getId();

            Post post = new Post(pTitle, pContent, pCode, pPic, null, cid, userId);
            PostDao postDao = new PostDao(ConnectionProvider.getConnection());

            if (postDao.savePost(post)) {

                String dirPath = request.getServletContext().getRealPath("/");

                for (int i = 0; i < allImage.size(); i++) {
                    
                    String newImgPath = dirPath + "blog_pic" + File.separator + allImageName[i];

                    Helper.saveFile(allImage.get(i).getInputStream(), newImgPath);
                }

                out.println("done");

            } else {
                out.print("error");
            }

        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
