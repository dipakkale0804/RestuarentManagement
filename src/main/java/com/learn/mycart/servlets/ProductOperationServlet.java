
package com.learn.mycart.servlets;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

// Import missing classes
import com.learn.mycart.entities.Category;
import com.learn.mycart.entities.Product;
import com.learn.mycart.dao.CategoryDao;
import com.learn.mycart.dao.ProductDao;
import com.learn.mycart.helper.FactoryProvider;

@MultipartConfig
public class ProductOperationServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {

            String op = request.getParameter("operation");

            if (op != null && op.trim().equals("addcategory")) {

                // Fetching category data
                String title = request.getParameter("catTitle");
                String description = request.getParameter("catDescription");

                Category category = new Category();
                category.setCategoryTitle(title);
                category.setCategoryDescription(description);

                // Save category to the database
                CategoryDao categoryDao = new CategoryDao(FactoryProvider.getFactory());
                int catId = categoryDao.saveCategory(category);

                // Store success message in session and redirect
                HttpSession httpSession = request.getSession();
                httpSession.setAttribute("message", "Category Added Successfully: " + catId);
                response.sendRedirect("admin.jsp");
                return;

            } else if (op != null && op.trim().equals("addproduct")) {
                // Add product
                try {
                    String pName = request.getParameter("pName");
                    String pDesc = request.getParameter("pDesc");
                    int pPrice = Integer.parseInt(request.getParameter("pPrice"));
                    int pDiscount = Integer.parseInt(request.getParameter("pDiscount"));
                    int pQuantity = Integer.parseInt(request.getParameter("pQuantity"));
                    int catId = Integer.parseInt(request.getParameter("catId"));
                    Part part = request.getPart("pPic");

                    Product p = new Product();
                    p.setpName(pName);
                    p.setpDesc(pDesc);
                    p.setpPrice(pPrice);
                    p.setpDiscount(pDiscount);
                    p.setpQuantity(pQuantity);
                    p.setpPhoto(part.getSubmittedFileName());

                    // Get category by ID
                    CategoryDao cdao = new CategoryDao(FactoryProvider.getFactory());
                    Category category = cdao.getCategoryById(catId);

                    p.setCategory(category);

                    // Save product to the database
                    ProductDao pdao = new ProductDao(FactoryProvider.getFactory());
                    pdao.saveProduct(p); // Uncommented to save product

                    // File upload processing
                    String path = getServletContext().getRealPath("/img") + File.separator + "products" + File.separator + part.getSubmittedFileName();
                    System.out.println("Saving file to: " + path);

                    //uploading code
                    try {

                        FileOutputStream fos = new FileOutputStream(path);

                        InputStream is = part.getInputStream();

                        //reading data
                        byte[] data = new byte[is.available()];

                        is.read(data);

                        //writing the data
                        fos.write(data);
                        fos.close();

                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                    
                    
                    File file = new File(path);
                    file.getParentFile().mkdirs(); // Ensure the directory exists

                    try (InputStream is = part.getInputStream(); FileOutputStream fos = new FileOutputStream(file)) {
                        byte[] buffer = new byte[1024];
                        int bytesRead;
                        while ((bytesRead = is.read(buffer)) != -1) {
                            fos.write(buffer, 0, bytesRead);
                        }
                    }

                    out.println("Product saved successfully");

                    HttpSession httpSession = request.getSession();
                    httpSession.setAttribute("message", "Product is added successfully");
                    response.sendRedirect("admin.jsp");
                    return;

                } catch (NumberFormatException e) {
                    out.println("Invalid number format: " + e.getMessage());
                } catch (Exception e) {
                    out.println("An error occurred: " + e.getMessage());
                }
            }
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}

