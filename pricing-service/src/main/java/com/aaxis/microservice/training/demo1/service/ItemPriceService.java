package com.aaxis.microservice.training.demo1.service;

import com.aaxis.microservice.training.demo1.dao.ItemPriceDAO;
import com.aaxis.microservice.training.demo1.domain.ItemPrice;
import lombok.extern.slf4j.Slf4j;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.Optional;

@Component
@Slf4j
public class ItemPriceService {
    /**
     * If IDE enable lombok plugin, will directly use static 'log' method, this 'logger' will be unnecessary
     */
    private final Logger logger = LoggerFactory.getLogger(this.getClass());

    @Autowired
    private ItemPriceDAO mItemPriceDAO;



    public ItemPrice findItemPriceById(String pProductId) {
        logger.debug("findItemPriceById() for product: {}", pProductId);
        Optional<ItemPrice> optionalItemPrice = mItemPriceDAO.findById(pProductId);
        if (optionalItemPrice.isPresent()) {
            ItemPrice price = optionalItemPrice.get();
            logger.debug("findItemPriceById() found price:{} for product:{}", price.getId(), pProductId);
            return price;
        }
        logger.warn("findItemPriceById() cannot find price for product:{}", pProductId);
        return null;
    }



    public void initData() {
        logger.info("initData()");
        mItemPriceDAO.insertItemPrice();
    }

}
