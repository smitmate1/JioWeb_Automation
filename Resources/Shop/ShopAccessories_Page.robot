*** Settings ***
Library                                    SeleniumLibrary
Resource                                   ../Local_Keywords.robot
Resource                                   ShopPage_PO/Accessories_PO/Redirection_To_Accessories.robot
Resource                                   ShopPage_PO/Accessories_PO/Buy_Any_Product.robot
Resource                                   ShopPage_PO/Accessories_PO/AccessoriesPagePO/MostPop_MostVal.robot
Resource                                   ../../Resources/Shop/ShopPage_PO/Accessories_PO/AccessoriesPagePO/Filter_Button.robot
Resource                                   ../../Resources/Shop/ShopPage_PO/Accessories_PO/AccessoriesProductPagePO/Product_Details.robot

*** Keywords ***
Check functionality to Payment Method page
    Landing on Accessories Page
    Add To Cart Game Controller To Payment Page

Check 'Most Popular' and 'Most Value' sections UI and Functionality
    Landing on Accessories Page                # Test Case : 92767
    Checking UI of Accessories Most Popular and Most Value Section

Check Each Accessories Product UI and Functionality
    Landing on Accessories Page
    Full UI Accessories

Check Show Filter UI and Functionality
    Landing on Accessories Page
    Checking Filter UI & Functionality        # Testcase : 92774,92775
    Checking PriceRange Filter UI             # Testcase : 92777,92779
    Checking Filter Brand UI                  
    Checking Filter Category UI               # Testcase : 92780
    Checking Multiple Filter                  # Testcase : 92782
