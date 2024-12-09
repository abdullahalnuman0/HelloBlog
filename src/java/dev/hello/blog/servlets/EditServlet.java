package dev.hello.blog.servlets;

import dev.hello.blog.dao.UserDao;
import dev.hello.blog.entities.Message;
import dev.hello.blog.entities.User;
import dev.hello.blog.helper.ConnectionProvider;
import dev.hello.blog.helper.Helper;
import dev.hello.blog.helper.SecurityHelper;
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
import java.util.Random;

@MultipartConfig // if form send file type data [Note: only text type data this is not used]
public class EditServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {

            // Fetch all data---
            String name = request.getParameter("user_name").trim();
            String email = request.getParameter("user_email").trim();
            String password = request.getParameter("user_password").trim();
            String about = request.getParameter("user_about").trim();
            if (about == null || about.isEmpty()) {
                about = "Hey! I'm using HelloBlog";
            }

            //File/Image Fetch
            Part part = request.getPart("user_image");
            String imageName = part.getSubmittedFileName().trim();
            imageName = (imageName == null || imageName.isEmpty()) ? null : ("IMG_" + System.currentTimeMillis() + "_" + new Random().nextInt(1000, 100000)) + imageName;

            // get the user from session
            HttpSession session = request.getSession();
            User user = (User) session.getAttribute("currentUser");
            user.setName(name);
            user.setEmail(email);
            user.setPassword(password);
            user.setAbout(about);
            String oldImgName = user.getProfile();
            if (imageName != null) {
                user.setProfile(imageName);
            }

            //update database
            UserDao userDao = new UserDao(ConnectionProvider.getConnection());
            boolean ans = userDao.updateUser(user);
            Message msg = new Message("Profile details updated...", "success", "alert-success");

            if (ans) {

                if (imageName != null) {

                    String dirPath = request.getServletContext().getRealPath("/");
                    String newImgPath = dirPath + "pics" + File.separator + imageName;

                    Helper.deleteFile(dirPath, oldImgName); // Delete old image

                    if (Helper.saveFile(part.getInputStream(), newImgPath)) {

                        //msg = new Message("Profile details updated...", "success", "alert-success");
                        session.setAttribute("msg", msg);

                    } else {

                        //msg = new Message("Image not uploaded... try again", "error", "alert-danger");
                        msg.setContent("Image not uploaded... try again");
                        msg.setType("error");
                        msg.setCssClass("alert-danger");
                        session.setAttribute("msg", msg);
                    }

                } else {
                    //msg = new Message("Profile details updated...", "success", "alert-success");
                    session.setAttribute("msg", msg);
                }

            } else {
                //msg = new Message("Something went wrong... try again", "error", "alert-danger");
                msg.setContent("Something went wrong... try again");
                msg.setType("error");
                msg.setCssClass("alert-danger");
                session.setAttribute("msg", msg);
            }

            response.sendRedirect("dashboard?name=" + user.getName() + "&uid=" + SecurityHelper.encodeData(user.getId()));

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
