package main

import (
	"crypto/rand"
	"crypto/rsa"
	"crypto/x509"
	"encoding/pem"
	"fmt"
	"os"
)

func readPrivateKey(filename string) (*rsa.PrivateKey, error) {
	keyBytes, err := os.ReadFile(filename)
	if err != nil {
		return nil, err
	}

	block, _ := pem.Decode(keyBytes)
	if block == nil {
		return nil, fmt.Errorf("Failed to decode PEM block")
	}

	privateKey, err := x509.ParsePKCS1PrivateKey(block.Bytes)
	if err != nil {
		return nil, fmt.Errorf("Failed to decode PEM block")
	}

	return privateKey, nil

}

func readPublicKey(filename string) (*rsa.PublicKey, error) {
	keyBytes, err := os.ReadFile(filename)
	if err != nil {
		return nil, err
	}

	block, _ := pem.Decode(keyBytes)
	if block == nil {
		return nil, fmt.Errorf("Failed to decode PEM block")
	}

	publicKey, err := x509.ParsePKIXPublicKey(block.Bytes)
	if err != nil {
		return nil, err
	}

	return publicKey.(*rsa.PublicKey), nil
}

func encryptMessage(publicKey *rsa.PublicKey, plaintext []byte) ([]byte, error) {
	ciphertext, err := rsa.EncryptPKCS1v15(rand.Reader, publicKey, plaintext)
	if err != nil {
		return nil, err
	}
	return ciphertext, nil
}

func decryptMessage(privateKey *rsa.PrivateKey, ciphertext []byte) ([]byte, error) {
	plaintext, err := rsa.DecryptPKCS1v15(rand.Reader, privateKey, ciphertext)
	if err != nil {
		return nil, err
	}
	return plaintext, nil
}

func main() {
	// Read the keys
	// The locations will be in var
	privateKey, _ := readPrivateKey("private.pem")
	publicKey, _ := readPublicKey("public.pem")

	plaintext := []byte("I'll see you on the dark side of the moon!")
	// Plaintext will come from somewhere else. This is just to test

	// Encrypt!
	ciphertext, _ := encryptMessage(publicKey, plaintext)
	fmt.Printf("Ciphertext: %x\n", ciphertext)

	decryptedPlaintext, _ := decryptMessage(privateKey, ciphertext)
	fmt.Printf("Decrypted message: %s\n", decryptedPlaintext)
}
