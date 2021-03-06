package com.aaxis.microservice.training.demo1.controller;

import com.aaxis.microservice.training.demo1.domain.ProductResult;
import com.aaxis.microservice.training.demo1.service.CatalogFeignClient;
import com.alibaba.fastjson.JSONObject;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.security.test.context.support.WithMockUser;
import org.springframework.test.annotation.Rollback;
import org.springframework.test.context.junit4.SpringRunner;
import org.springframework.test.web.servlet.MockMvc;

import java.util.HashMap;
import java.util.Map;

import static org.assertj.core.api.AssertionsForClassTypes.assertThat;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.print;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

/**
 * Created by terrence on 2018/10/12.
 */
@RunWith(SpringRunner.class)
@WebMvcTest(controllers = RestProductController.class)
@Rollback
public class RestProductControllerMockTest {

    @Autowired
    private MockMvc mvc;

    @MockBean// stub test simple please refer to com.aaxis.microservice.training.demo1.service.ProductControllerTest 
    private CatalogFeignClient mCatalogFeignClient;



    @Test
    @WithMockUser
    public void productSearch() throws Exception {
        String productIdK = "productId";
        String nameK = "name";
        String pageK = "page";
        String sortNameK = "sortName";
        String sortValueK = "sortValue";

        String productIdV = "productId";
        String nameV = "name";
        String pageV = "1";
        String sortNameV = "sortName";
        String sortValueV = "sortValue";

        String responseString = mvc.perform(
                get("/rest/product/search").param(productIdK, productIdV).param(nameK, nameV).param(pageK, pageV)
                        .param(sortNameK, sortNameV).param(sortValueK, sortValueV)).andDo(print())
                .andExpect(status().isOk()).andReturn().getResponse().getContentAsString();
        assertThat(responseString).isNotBlank();
        ProductResult response = JSONObject.parseObject(responseString, ProductResult.class);

        assertThat(response).extracting(ProductResult::getRequest).isNotEmpty().contains(
                getMap(productIdK, productIdV, nameK, nameV, pageK, pageV, sortNameK, sortNameV, sortValueK,
                        sortValueV));
    }



    private Map getMap(String pProductIdK, String pProductIdV, String pNameK, String pNameV, String pPageK,
            String pPageV, String pSortNameK, String pSortNameV, String pSortValueK, String pSortValueV) {
        Map map = new HashMap();
        map.put(pProductIdK, pProductIdV);
        map.put(pNameK, pNameV);
        map.put(pPageK, Integer.parseInt(pPageV));
        map.put(pSortNameK, pSortNameV);
        map.put(pSortValueK, pSortValueV);
        return map;
    }

}