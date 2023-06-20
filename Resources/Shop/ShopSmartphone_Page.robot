*** Settings ***
Library                                    SeleniumLibrary
Resource                                   ShopPage_PO/Smartphone_PO/RedirectionToSmartphone.robot
Resource                                   ShopPage_PO/Smartphone_PO/SmartphonePagePO/MostPop_MostVal.robot
Resource                                   ../../Resources/Shop/ShopPage_PO/Smartphone_PO/SmartphonePagePO/AllProducts.robot
Resource                                   ../../Resources/Shop/ShopPage_PO/Smartphone_PO/SmartphonePagePO/FilterButton.robot
Resource                                   ../../Resources/Shop/ShopPage_PO/Smartphone_PO/SmartphoneProductPagePO/Product_Details.robot
Resource                                   ../Local_Keywords.robot

*** Keywords ***

Check 'Most Popular' and 'Most Value' sections UI and Functionality
    Landing on Smartphone Page
    Checking UI of Smartphone Most Popular and Most Value Section

Check Each Smartphone Product UI and Functionality
    Landing on Smartphone Page
    Checking UI and Functionality Of Smartphone Product

Check Show Filter UI and Functionality
    Landing on Smartphone Page
    Checking Filter UI & Functionality
    Checking PriceRange Filter UI
    Checking Filter Brand UI
    Checking Multiple Filter                #Testcase: 92607
    
