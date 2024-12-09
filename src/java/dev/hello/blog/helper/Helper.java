package dev.hello.blog.helper;

import jakarta.servlet.http.Part;
import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Random;

public class Helper   {

    public static boolean deleteFile(String directory, String path) {

        if (path.equals("default.png")) {
            return true;
        }

        try {

            path = directory + "pics" + File.separator + path;

            File file = new File(path);
            return file.delete();

        } catch (Exception e) {
            e.printStackTrace();

        }

        return false;
    }
    
    public static boolean deleteBlogPostFile(String directory, String path) {

        if (path.equals("default-image.avif")) {
            return true;
        }

        try {

            path = directory + "blog_pic" + File.separator + path;

            File file = new File(path);
            return file.delete();

        } catch (Exception e) {
            e.printStackTrace();

        }

        return false;
    }

    public static boolean saveFile(InputStream is, String path) {

        try {

            byte[] b = new byte[is.available()];
            is.read(b);

            FileOutputStream fos = new FileOutputStream(path);
            fos.write(b);

            fos.flush();
            fos.close();

            return true;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    public static ArrayList<Part> getAllImage(Collection<Part> parts, String filedName) {

        ArrayList<Part> imagePart = new ArrayList<>();

        for (Part part : parts) {

            if (part.getName().equals(filedName) && part.getSize() > 0) {
                imagePart.add(part);
            }
        }
        return imagePart;
    }

    public static String[] getAllImageName(ArrayList<Part> parts) {

        String[] names = new String[parts.size()];

        for (int i = 0; i < parts.size(); i++) {

            names[i] = ("IMG_" + System.currentTimeMillis() + "_" + new Random().nextInt(1000, 100000)) + "_" + parts.get(i).getSubmittedFileName();
        }

        return names;
    }

    
    public static String getFilesName(String[] fileNames) {

        StringBuilder sb = new StringBuilder();
        
        for(String fileName : fileNames){
            sb.append(fileName);
            sb.append("--Hello!Blog--");
        }
       
        return sb.toString();
    }

    
    
    //--------------------------------------------------------------------------------
    //--------------------------------------------------------------------------------
    

}
