*** Settings ***
Library                             SeleniumLibrary
Resource                            ../Common.robot
Resource                            ../Excel_Activity.robot
Resource                            ../Local_Keywords.robot
Resource                            ShopPage_PO/Smart_Devices_PO/RedirectionToSmartDevices.robot
Resource                            ShopPage_PO/Accessories_PO/Redirection_To_Accessories.robot
Resource                            ShopPage_PO/Discover_PO/RedirectionToDiscover.robot
Resource                            ShopPage_PO/Smartphone_PO/RedirectionToSmartphone.robot
Resource                            ShopPage_PO/AddToCart_PO/Redirection.robot

*** Keywords ***
Verifying Add to Cart Button Functionality 
    Landing on Accessories Page
    Checking Add to Cart Button Functionality 

Checking the functionality of form elements on Shopping Cart
    Landing on Accessories Page
    Checkout section
