//
//  RemoteServiceFactory.swift
//  ALNetworking
//
//  Created by Arpit Lokwani on 17/05/17.
//  Copyright © 2017 Arpit Lokwani. All rights reserved.
//

import UIKit

class RemoteServiceFactory: NSObject {
    
    func loginService() -> String {
        return "method=customerLogin";
    }
    func registrationService() -> String {
        return "method=customerRegistration";
    }
    func bannerService() -> String{
        return "/v1/ezone/mobileHome/getHomePageBannersss"
    }
    func staticBannerService() -> String{
        return "method=staticBanners"
    }
    func shareItService() -> String {
        return "method=shareIt"
    }
    func getCategoryProduct() -> String {
        return "method=getCategoryProducts"
    }
    func getFirstAndSecondLevalCategoty() -> String {
        return "method=firstSecondLevelCategory"
    }
    func getProductList() -> String {
        return "method=productList"
    }
    func forgotPassword() -> String {
        return "method=customerForgetPassword"
    }
    func addToWishlist() -> String {
        return "method=addToWishlist"
    }
    func getSortAttributeList() -> String {
        return "method=sortAttributeList"
    }
    func getWishlistProducts() -> String {
        return "method=wishlistProducts"
    }
    func getDefaultAddressService() -> String {
        return "customerDefaultAddress"
    }
    func setCheckoutAddressService() -> String {
        return "setCheckoutAddresses"
    }
    func pincodeServices() -> String {
         return "pincode/getstore/"
    }
    func cartServices() -> String {
        return "/data/2.5/weather?"
    }
    func addToCart() -> String {
        return "method=addToCart"
    }
    
    func getAreas() -> String {
        return "pincode/getareas/560066"
    }
    
    
}
