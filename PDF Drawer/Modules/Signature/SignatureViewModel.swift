//
//  SignatureViewModel.swift
//  the-line
//
//  Created by Salah Khaled on 14/02/2024.
//

import Foundation

class SignatureViewModel {
    
    private var signatureList: [UserSignature] = []
    
    var didGetSignatureHandler: (() -> Void)?
    var didFailedSignatureHandler: ((String) -> Void)?
    
    func getSignatueCount() -> Int {
        return signatureList.count
    }
    
    func getSignatureAt(index: Int) -> UserSignature {
        return signatureList[index]
    }
    
}

// MARK: - API
extension SignatureViewModel {
    func getUserSignature() {
        guard let user = UserRepo.shared.local.get() else {
            didFailedSignatureHandler?("session_expired".l())
            return
        }
        let empNo = user.empNo ?? ""
        
        UserRepo.shared.getUserSignature(empNo: empNo) { [ weak self ] response in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch response {
                case .onSuccess(let userSignature):
                    self.signatureList = userSignature
                    self.didGetSignatureHandler?()
                case let .onFailure(error):
                    self.didFailedSignatureHandler?(error.message ?? "session_expired".l())
                }
            }
        }
    }
}

