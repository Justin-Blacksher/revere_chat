package main

import (
	"crypto/rand"
	"crypto/rsa"
	"crypto/x509"
	"encoding/pem"
	"fmt"
	"os"
)

func main() {
	// Generate a new RSA key pair
	privateKey, err := Create_Private_Key()
	if err != nil {
		fmt.Errorf("Error generating the RSA key: %v", err)
	}
	// Generate the public key
	publicKey, err := Create_Public_Key(privateKey)
	if err != nil {
		fmt.Errorf("Error generating the RSA key: %v", err)
	}
	// Save private key to a file
	Save_Private_Key(privateKey)
	// Save the public key
	Save_Public_Key(publicKey)

}

func Create_Private_Key() (*rsa.PrivateKey, error) {
	privateKey, err := rsa.GenerateKey(rand.Reader, 2048)
	if err != nil {
		return nil, fmt.Errorf("Error generating the RSA key: %v", err)
	}
	return privateKey, nil
}

func Create_Public_Key(privateKey *rsa.PrivateKey) (*rsa.PublicKey, error) {
	publicKey := &privateKey.PublicKey
	return publicKey, nil
}

func Save_Private_Key(privateKey *rsa.PrivateKey) {
	privateKeyBytes := x509.MarshalPKCS1PrivateKey(privateKey)
	privateKeyBlock := &pem.Block{
		Type:  "RSA Private Key",
		Bytes: privateKeyBytes,
	}

	privatePem, err := os.Create("private.pem")
	if err != nil {
		fmt.Println("Error creating private.pem", err)
		return
	}

	err = pem.Encode(privatePem, privateKeyBlock)
	if err != nil {
		fmt.Println("Error encoding the private pem:", err)
		return
	}
	fmt.Println("Private key saved to private.pem")
}

func Save_Public_Key(publicKey *rsa.PublicKey) {
	publicKeyBytes, err := x509.MarshalPKIXPublicKey(publicKey)
	if err != nil {
		fmt.Println("Error dumping public key: ", err)
		return
	}
	publicKeyBlock := &pem.Block{
		Type:  "Public Key",
		Bytes: publicKeyBytes,
	}
	publicPem, err := os.Create("public.pem")
	if err != nil {
		fmt.Println("Error creating public.pem: ", err)
		return
	}
	err = pem.Encode(publicPem, publicKeyBlock)
	if err != nil {
		fmt.Println("Error encoding public pem:", err)
		return
	}
	fmt.Println("Public key saved to public.pem")
}
