package com.aaxis.microservice.training.demo1.controller;

import com.aaxis.microservice.training.demo1.domain.Product;
import com.aaxis.microservice.training.demo1.domain.ProductResult;
import com.aaxis.microservice.training.demo1.domain.RestPageImpl;
import com.aaxis.microservice.training.demo1.service.CatalogFeignClient;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping(value = "/rest/category", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
public class RestCategoryController {

    @Autowired
    private CatalogFeignClient mCatalogFeignClient;



    @GetMapping("/initData")
    public String initData() {
        mCatalogFeignClient.categoryInitData();
        return "redirect:/login";
    }



    @GetMapping(value = { "/{categoryId}/{page}", "/{categoryId}/{page}/{sortName}/{sortValue}" })
    public ProductResult restFindProductsByCategory(@PathVariable("categoryId") String categoryId,
            @PathVariable(name = "page", required = false) String page,
            @PathVariable(name = "sortName", required = false) String sortName,
            @PathVariable(name = "sortValue", required = false) String sortValue) {
        RestPageImpl<Product> pageProducts = mCatalogFeignClient
                .findProductsInPLP(categoryId, Integer.parseInt(page), sortName, sortValue);
        ProductResult productResult = new ProductResult();
        productResult.setPageProducts(pageProducts);
        productResult.getRequest().put("requestCategoryId", categoryId);
        productResult.getRequest().put("page", page);
        productResult.getRequest().put("sortName", sortName);
        productResult.getRequest().put("sortValue", sortValue);
        return productResult;
    }

}
