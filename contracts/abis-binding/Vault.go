// Code generated - DO NOT EDIT.
// This file is a generated binding and any manual changes will be lost.

package main

import (
	"errors"
	"math/big"
	"strings"

	ethereum "github.com/ethereum/go-ethereum"
	"github.com/ethereum/go-ethereum/accounts/abi"
	"github.com/ethereum/go-ethereum/accounts/abi/bind"
	"github.com/ethereum/go-ethereum/common"
	"github.com/ethereum/go-ethereum/core/types"
	"github.com/ethereum/go-ethereum/event"
)

// Reference imports to suppress errors if they are not otherwise used.
var (
	_ = errors.New
	_ = big.NewInt
	_ = strings.NewReader
	_ = ethereum.NotFound
	_ = bind.Bind
	_ = common.Big1
	_ = types.BloomLookup
	_ = event.NewSubscription
	_ = abi.ConvertType
)

// VaultMetaData contains all meta data concerning the Vault contract.
var VaultMetaData = &bind.MetaData{
	ABI: "[{\"inputs\":[{\"internalType\":\"string\",\"name\":\"_shareName\",\"type\":\"string\"},{\"internalType\":\"string\",\"name\":\"_shareSymbol\",\"type\":\"string\"},{\"internalType\":\"address\",\"name\":\"_pool\",\"type\":\"address\"},{\"internalType\":\"address\",\"name\":\"_tokenSpin\",\"type\":\"address\"}],\"stateMutability\":\"nonpayable\",\"type\":\"constructor\"},{\"anonymous\":false,\"inputs\":[{\"indexed\":true,\"internalType\":\"address\",\"name\":\"owner\",\"type\":\"address\"},{\"indexed\":true,\"internalType\":\"address\",\"name\":\"spender\",\"type\":\"address\"},{\"indexed\":false,\"internalType\":\"uint256\",\"name\":\"value\",\"type\":\"uint256\"}],\"name\":\"Approval\",\"type\":\"event\"},{\"anonymous\":false,\"inputs\":[{\"indexed\":true,\"internalType\":\"address\",\"name\":\"previousOwner\",\"type\":\"address\"},{\"indexed\":true,\"internalType\":\"address\",\"name\":\"newOwner\",\"type\":\"address\"}],\"name\":\"OwnershipTransferred\",\"type\":\"event\"},{\"anonymous\":false,\"inputs\":[{\"indexed\":false,\"internalType\":\"address\",\"name\":\"account\",\"type\":\"address\"}],\"name\":\"Paused\",\"type\":\"event\"},{\"anonymous\":false,\"inputs\":[{\"indexed\":true,\"internalType\":\"address\",\"name\":\"from\",\"type\":\"address\"},{\"indexed\":true,\"internalType\":\"address\",\"name\":\"to\",\"type\":\"address\"},{\"indexed\":false,\"internalType\":\"uint256\",\"name\":\"value\",\"type\":\"uint256\"}],\"name\":\"Transfer\",\"type\":\"event\"},{\"anonymous\":false,\"inputs\":[{\"indexed\":false,\"internalType\":\"address\",\"name\":\"account\",\"type\":\"address\"}],\"name\":\"Unpaused\",\"type\":\"event\"},{\"inputs\":[{\"internalType\":\"uint256\",\"name\":\"\",\"type\":\"uint256\"}],\"name\":\"IGOs\",\"outputs\":[{\"internalType\":\"address\",\"name\":\"\",\"type\":\"address\"}],\"stateMutability\":\"view\",\"type\":\"function\"},{\"inputs\":[{\"internalType\":\"address\",\"name\":\"owner\",\"type\":\"address\"},{\"internalType\":\"address\",\"name\":\"spender\",\"type\":\"address\"}],\"name\":\"allowance\",\"outputs\":[{\"internalType\":\"uint256\",\"name\":\"\",\"type\":\"uint256\"}],\"stateMutability\":\"view\",\"type\":\"function\"},{\"inputs\":[{\"internalType\":\"address\",\"name\":\"spender\",\"type\":\"address\"},{\"internalType\":\"uint256\",\"name\":\"amount\",\"type\":\"uint256\"}],\"name\":\"approve\",\"outputs\":[{\"internalType\":\"bool\",\"name\":\"\",\"type\":\"bool\"}],\"stateMutability\":\"nonpayable\",\"type\":\"function\"},{\"inputs\":[],\"name\":\"balance\",\"outputs\":[{\"internalType\":\"uint256\",\"name\":\"\",\"type\":\"uint256\"}],\"stateMutability\":\"view\",\"type\":\"function\"},{\"inputs\":[{\"internalType\":\"address\",\"name\":\"account\",\"type\":\"address\"}],\"name\":\"balanceOf\",\"outputs\":[{\"internalType\":\"uint256\",\"name\":\"\",\"type\":\"uint256\"}],\"stateMutability\":\"view\",\"type\":\"function\"},{\"inputs\":[{\"internalType\":\"string\",\"name\":\"_gameName\",\"type\":\"string\"},{\"internalType\":\"uint256\",\"name\":\"_totalDollars\",\"type\":\"uint256\"},{\"internalType\":\"address\",\"name\":\"_paymentToken\",\"type\":\"address\"},{\"internalType\":\"uint256\",\"name\":\"_price\",\"type\":\"uint256\"},{\"internalType\":\"uint256\",\"name\":\"_priceDecimal\",\"type\":\"uint256\"},{\"internalType\":\"uint256\",\"name\":\"_duration\",\"type\":\"uint256\"},{\"internalType\":\"uint256\",\"name\":\"_multiplier\",\"type\":\"uint256\"}],\"name\":\"createIGO\",\"outputs\":[],\"stateMutability\":\"nonpayable\",\"type\":\"function\"},{\"inputs\":[],\"name\":\"decimals\",\"outputs\":[{\"internalType\":\"uint8\",\"name\":\"\",\"type\":\"uint8\"}],\"stateMutability\":\"view\",\"type\":\"function\"},{\"inputs\":[{\"internalType\":\"address\",\"name\":\"spender\",\"type\":\"address\"},{\"internalType\":\"uint256\",\"name\":\"subtractedValue\",\"type\":\"uint256\"}],\"name\":\"decreaseAllowance\",\"outputs\":[{\"internalType\":\"bool\",\"name\":\"\",\"type\":\"bool\"}],\"stateMutability\":\"nonpayable\",\"type\":\"function\"},{\"inputs\":[{\"internalType\":\"uint256\",\"name\":\"_amount\",\"type\":\"uint256\"}],\"name\":\"deposit\",\"outputs\":[],\"stateMutability\":\"nonpayable\",\"type\":\"function\"},{\"inputs\":[{\"internalType\":\"address\",\"name\":\"account\",\"type\":\"address\"}],\"name\":\"getUserStaked\",\"outputs\":[{\"internalType\":\"uint256\",\"name\":\"\",\"type\":\"uint256\"}],\"stateMutability\":\"view\",\"type\":\"function\"},{\"inputs\":[{\"internalType\":\"address\",\"name\":\"spender\",\"type\":\"address\"},{\"internalType\":\"uint256\",\"name\":\"addedValue\",\"type\":\"uint256\"}],\"name\":\"increaseAllowance\",\"outputs\":[{\"internalType\":\"bool\",\"name\":\"\",\"type\":\"bool\"}],\"stateMutability\":\"nonpayable\",\"type\":\"function\"},{\"inputs\":[],\"name\":\"maxStakeAmount\",\"outputs\":[{\"internalType\":\"uint256\",\"name\":\"\",\"type\":\"uint256\"}],\"stateMutability\":\"view\",\"type\":\"function\"},{\"inputs\":[],\"name\":\"membersLength\",\"outputs\":[{\"internalType\":\"uint256\",\"name\":\"\",\"type\":\"uint256\"}],\"stateMutability\":\"view\",\"type\":\"function\"},{\"inputs\":[],\"name\":\"migrateBalances\",\"outputs\":[],\"stateMutability\":\"nonpayable\",\"type\":\"function\"},{\"inputs\":[],\"name\":\"minStakeAmount\",\"outputs\":[{\"internalType\":\"uint256\",\"name\":\"\",\"type\":\"uint256\"}],\"stateMutability\":\"view\",\"type\":\"function\"},{\"inputs\":[],\"name\":\"name\",\"outputs\":[{\"internalType\":\"string\",\"name\":\"\",\"type\":\"string\"}],\"stateMutability\":\"view\",\"type\":\"function\"},{\"inputs\":[{\"internalType\":\"address\",\"name\":\"_igo\",\"type\":\"address\"},{\"internalType\":\"uint256\",\"name\":\"_percentage\",\"type\":\"uint256\"}],\"name\":\"notifyVesting\",\"outputs\":[],\"stateMutability\":\"nonpayable\",\"type\":\"function\"},{\"inputs\":[],\"name\":\"owner\",\"outputs\":[{\"internalType\":\"address\",\"name\":\"\",\"type\":\"address\"}],\"stateMutability\":\"view\",\"type\":\"function\"},{\"inputs\":[],\"name\":\"pause\",\"outputs\":[],\"stateMutability\":\"nonpayable\",\"type\":\"function\"},{\"inputs\":[],\"name\":\"paused\",\"outputs\":[{\"internalType\":\"bool\",\"name\":\"\",\"type\":\"bool\"}],\"stateMutability\":\"view\",\"type\":\"function\"},{\"inputs\":[],\"name\":\"renounceOwnership\",\"outputs\":[],\"stateMutability\":\"nonpayable\",\"type\":\"function\"},{\"inputs\":[{\"internalType\":\"uint256\",\"name\":\"_batchSize\",\"type\":\"uint256\"}],\"name\":\"setBatchSize\",\"outputs\":[],\"stateMutability\":\"nonpayable\",\"type\":\"function\"},{\"inputs\":[{\"internalType\":\"address\",\"name\":\"_igo\",\"type\":\"address\"},{\"internalType\":\"uint256\",\"name\":\"_allocationTime\",\"type\":\"uint256\"},{\"internalType\":\"uint256\",\"name\":\"_publicTime\",\"type\":\"uint256\"}],\"name\":\"setPeriods\",\"outputs\":[],\"stateMutability\":\"nonpayable\",\"type\":\"function\"},{\"inputs\":[{\"internalType\":\"address\",\"name\":\"_igo\",\"type\":\"address\"},{\"internalType\":\"address\",\"name\":\"_token\",\"type\":\"address\"},{\"internalType\":\"uint256\",\"name\":\"_decimal\",\"type\":\"uint256\"}],\"name\":\"setToken\",\"outputs\":[],\"stateMutability\":\"nonpayable\",\"type\":\"function\"},{\"inputs\":[],\"name\":\"start\",\"outputs\":[],\"stateMutability\":\"nonpayable\",\"type\":\"function\"},{\"inputs\":[],\"name\":\"symbol\",\"outputs\":[{\"internalType\":\"string\",\"name\":\"\",\"type\":\"string\"}],\"stateMutability\":\"view\",\"type\":\"function\"},{\"inputs\":[],\"name\":\"totalSupply\",\"outputs\":[{\"internalType\":\"uint256\",\"name\":\"\",\"type\":\"uint256\"}],\"stateMutability\":\"view\",\"type\":\"function\"},{\"inputs\":[{\"internalType\":\"address\",\"name\":\"recipient\",\"type\":\"address\"},{\"internalType\":\"uint256\",\"name\":\"amount\",\"type\":\"uint256\"}],\"name\":\"transfer\",\"outputs\":[{\"internalType\":\"bool\",\"name\":\"\",\"type\":\"bool\"}],\"stateMutability\":\"nonpayable\",\"type\":\"function\"},{\"inputs\":[{\"internalType\":\"address\",\"name\":\"sender\",\"type\":\"address\"},{\"internalType\":\"address\",\"name\":\"recipient\",\"type\":\"address\"},{\"internalType\":\"uint256\",\"name\":\"amount\",\"type\":\"uint256\"}],\"name\":\"transferFrom\",\"outputs\":[{\"internalType\":\"bool\",\"name\":\"\",\"type\":\"bool\"}],\"stateMutability\":\"nonpayable\",\"type\":\"function\"},{\"inputs\":[{\"internalType\":\"address\",\"name\":\"newOwner\",\"type\":\"address\"}],\"name\":\"transferOwnership\",\"outputs\":[],\"stateMutability\":\"nonpayable\",\"type\":\"function\"},{\"inputs\":[],\"name\":\"unpause\",\"outputs\":[],\"stateMutability\":\"nonpayable\",\"type\":\"function\"},{\"inputs\":[],\"name\":\"vaultBalance\",\"outputs\":[{\"internalType\":\"uint256\",\"name\":\"\",\"type\":\"uint256\"}],\"stateMutability\":\"view\",\"type\":\"function\"},{\"inputs\":[],\"name\":\"vaultInfo\",\"outputs\":[{\"internalType\":\"address\",\"name\":\"admin\",\"type\":\"address\"},{\"internalType\":\"address\",\"name\":\"pool\",\"type\":\"address\"},{\"internalType\":\"address\",\"name\":\"tokenSpin\",\"type\":\"address\"}],\"stateMutability\":\"view\",\"type\":\"function\"},{\"inputs\":[],\"name\":\"withdraw\",\"outputs\":[],\"stateMutability\":\"nonpayable\",\"type\":\"function\"},{\"inputs\":[{\"internalType\":\"address\",\"name\":\"_igo\",\"type\":\"address\"},{\"internalType\":\"uint256\",\"name\":\"token\",\"type\":\"uint256\"}],\"name\":\"withdrawIGOFunds\",\"outputs\":[],\"stateMutability\":\"nonpayable\",\"type\":\"function\"}]",
}

// VaultABI is the input ABI used to generate the binding from.
// Deprecated: Use VaultMetaData.ABI instead.
var VaultABI = VaultMetaData.ABI

// Vault is an auto generated Go binding around an Ethereum contract.
type Vault struct {
	VaultCaller     // Read-only binding to the contract
	VaultTransactor // Write-only binding to the contract
	VaultFilterer   // Log filterer for contract events
}

// VaultCaller is an auto generated read-only Go binding around an Ethereum contract.
type VaultCaller struct {
	contract *bind.BoundContract // Generic contract wrapper for the low level calls
}

// VaultTransactor is an auto generated write-only Go binding around an Ethereum contract.
type VaultTransactor struct {
	contract *bind.BoundContract // Generic contract wrapper for the low level calls
}

// VaultFilterer is an auto generated log filtering Go binding around an Ethereum contract events.
type VaultFilterer struct {
	contract *bind.BoundContract // Generic contract wrapper for the low level calls
}

// VaultSession is an auto generated Go binding around an Ethereum contract,
// with pre-set call and transact options.
type VaultSession struct {
	Contract     *Vault            // Generic contract binding to set the session for
	CallOpts     bind.CallOpts     // Call options to use throughout this session
	TransactOpts bind.TransactOpts // Transaction auth options to use throughout this session
}

// VaultCallerSession is an auto generated read-only Go binding around an Ethereum contract,
// with pre-set call options.
type VaultCallerSession struct {
	Contract *VaultCaller  // Generic contract caller binding to set the session for
	CallOpts bind.CallOpts // Call options to use throughout this session
}

// VaultTransactorSession is an auto generated write-only Go binding around an Ethereum contract,
// with pre-set transact options.
type VaultTransactorSession struct {
	Contract     *VaultTransactor  // Generic contract transactor binding to set the session for
	TransactOpts bind.TransactOpts // Transaction auth options to use throughout this session
}

// VaultRaw is an auto generated low-level Go binding around an Ethereum contract.
type VaultRaw struct {
	Contract *Vault // Generic contract binding to access the raw methods on
}

// VaultCallerRaw is an auto generated low-level read-only Go binding around an Ethereum contract.
type VaultCallerRaw struct {
	Contract *VaultCaller // Generic read-only contract binding to access the raw methods on
}

// VaultTransactorRaw is an auto generated low-level write-only Go binding around an Ethereum contract.
type VaultTransactorRaw struct {
	Contract *VaultTransactor // Generic write-only contract binding to access the raw methods on
}

// NewVault creates a new instance of Vault, bound to a specific deployed contract.
func NewVault(address common.Address, backend bind.ContractBackend) (*Vault, error) {
	contract, err := bindVault(address, backend, backend, backend)
	if err != nil {
		return nil, err
	}
	return &Vault{VaultCaller: VaultCaller{contract: contract}, VaultTransactor: VaultTransactor{contract: contract}, VaultFilterer: VaultFilterer{contract: contract}}, nil
}

// NewVaultCaller creates a new read-only instance of Vault, bound to a specific deployed contract.
func NewVaultCaller(address common.Address, caller bind.ContractCaller) (*VaultCaller, error) {
	contract, err := bindVault(address, caller, nil, nil)
	if err != nil {
		return nil, err
	}
	return &VaultCaller{contract: contract}, nil
}

// NewVaultTransactor creates a new write-only instance of Vault, bound to a specific deployed contract.
func NewVaultTransactor(address common.Address, transactor bind.ContractTransactor) (*VaultTransactor, error) {
	contract, err := bindVault(address, nil, transactor, nil)
	if err != nil {
		return nil, err
	}
	return &VaultTransactor{contract: contract}, nil
}

// NewVaultFilterer creates a new log filterer instance of Vault, bound to a specific deployed contract.
func NewVaultFilterer(address common.Address, filterer bind.ContractFilterer) (*VaultFilterer, error) {
	contract, err := bindVault(address, nil, nil, filterer)
	if err != nil {
		return nil, err
	}
	return &VaultFilterer{contract: contract}, nil
}

// bindVault binds a generic wrapper to an already deployed contract.
func bindVault(address common.Address, caller bind.ContractCaller, transactor bind.ContractTransactor, filterer bind.ContractFilterer) (*bind.BoundContract, error) {
	parsed, err := VaultMetaData.GetAbi()
	if err != nil {
		return nil, err
	}
	return bind.NewBoundContract(address, *parsed, caller, transactor, filterer), nil
}

// Call invokes the (constant) contract method with params as input values and
// sets the output to result. The result type might be a single field for simple
// returns, a slice of interfaces for anonymous returns and a struct for named
// returns.
func (_Vault *VaultRaw) Call(opts *bind.CallOpts, result *[]interface{}, method string, params ...interface{}) error {
	return _Vault.Contract.VaultCaller.contract.Call(opts, result, method, params...)
}

// Transfer initiates a plain transaction to move funds to the contract, calling
// its default method if one is available.
func (_Vault *VaultRaw) Transfer(opts *bind.TransactOpts) (*types.Transaction, error) {
	return _Vault.Contract.VaultTransactor.contract.Transfer(opts)
}

// Transact invokes the (paid) contract method with params as input values.
func (_Vault *VaultRaw) Transact(opts *bind.TransactOpts, method string, params ...interface{}) (*types.Transaction, error) {
	return _Vault.Contract.VaultTransactor.contract.Transact(opts, method, params...)
}

// Call invokes the (constant) contract method with params as input values and
// sets the output to result. The result type might be a single field for simple
// returns, a slice of interfaces for anonymous returns and a struct for named
// returns.
func (_Vault *VaultCallerRaw) Call(opts *bind.CallOpts, result *[]interface{}, method string, params ...interface{}) error {
	return _Vault.Contract.contract.Call(opts, result, method, params...)
}

// Transfer initiates a plain transaction to move funds to the contract, calling
// its default method if one is available.
func (_Vault *VaultTransactorRaw) Transfer(opts *bind.TransactOpts) (*types.Transaction, error) {
	return _Vault.Contract.contract.Transfer(opts)
}

// Transact invokes the (paid) contract method with params as input values.
func (_Vault *VaultTransactorRaw) Transact(opts *bind.TransactOpts, method string, params ...interface{}) (*types.Transaction, error) {
	return _Vault.Contract.contract.Transact(opts, method, params...)
}

// IGOs is a free data retrieval call binding the contract method 0x9d1a35bd.
//
// Solidity: function IGOs(uint256 ) view returns(address)
func (_Vault *VaultCaller) IGOs(opts *bind.CallOpts, arg0 *big.Int) (common.Address, error) {
	var out []interface{}
	err := _Vault.contract.Call(opts, &out, "IGOs", arg0)

	if err != nil {
		return *new(common.Address), err
	}

	out0 := *abi.ConvertType(out[0], new(common.Address)).(*common.Address)

	return out0, err

}

// IGOs is a free data retrieval call binding the contract method 0x9d1a35bd.
//
// Solidity: function IGOs(uint256 ) view returns(address)
func (_Vault *VaultSession) IGOs(arg0 *big.Int) (common.Address, error) {
	return _Vault.Contract.IGOs(&_Vault.CallOpts, arg0)
}

// IGOs is a free data retrieval call binding the contract method 0x9d1a35bd.
//
// Solidity: function IGOs(uint256 ) view returns(address)
func (_Vault *VaultCallerSession) IGOs(arg0 *big.Int) (common.Address, error) {
	return _Vault.Contract.IGOs(&_Vault.CallOpts, arg0)
}

// Allowance is a free data retrieval call binding the contract method 0xdd62ed3e.
//
// Solidity: function allowance(address owner, address spender) view returns(uint256)
func (_Vault *VaultCaller) Allowance(opts *bind.CallOpts, owner common.Address, spender common.Address) (*big.Int, error) {
	var out []interface{}
	err := _Vault.contract.Call(opts, &out, "allowance", owner, spender)

	if err != nil {
		return *new(*big.Int), err
	}

	out0 := *abi.ConvertType(out[0], new(*big.Int)).(**big.Int)

	return out0, err

}

// Allowance is a free data retrieval call binding the contract method 0xdd62ed3e.
//
// Solidity: function allowance(address owner, address spender) view returns(uint256)
func (_Vault *VaultSession) Allowance(owner common.Address, spender common.Address) (*big.Int, error) {
	return _Vault.Contract.Allowance(&_Vault.CallOpts, owner, spender)
}

// Allowance is a free data retrieval call binding the contract method 0xdd62ed3e.
//
// Solidity: function allowance(address owner, address spender) view returns(uint256)
func (_Vault *VaultCallerSession) Allowance(owner common.Address, spender common.Address) (*big.Int, error) {
	return _Vault.Contract.Allowance(&_Vault.CallOpts, owner, spender)
}

// Balance is a free data retrieval call binding the contract method 0xb69ef8a8.
//
// Solidity: function balance() view returns(uint256)
func (_Vault *VaultCaller) Balance(opts *bind.CallOpts) (*big.Int, error) {
	var out []interface{}
	err := _Vault.contract.Call(opts, &out, "balance")

	if err != nil {
		return *new(*big.Int), err
	}

	out0 := *abi.ConvertType(out[0], new(*big.Int)).(**big.Int)

	return out0, err

}

// Balance is a free data retrieval call binding the contract method 0xb69ef8a8.
//
// Solidity: function balance() view returns(uint256)
func (_Vault *VaultSession) Balance() (*big.Int, error) {
	return _Vault.Contract.Balance(&_Vault.CallOpts)
}

// Balance is a free data retrieval call binding the contract method 0xb69ef8a8.
//
// Solidity: function balance() view returns(uint256)
func (_Vault *VaultCallerSession) Balance() (*big.Int, error) {
	return _Vault.Contract.Balance(&_Vault.CallOpts)
}

// BalanceOf is a free data retrieval call binding the contract method 0x70a08231.
//
// Solidity: function balanceOf(address account) view returns(uint256)
func (_Vault *VaultCaller) BalanceOf(opts *bind.CallOpts, account common.Address) (*big.Int, error) {
	var out []interface{}
	err := _Vault.contract.Call(opts, &out, "balanceOf", account)

	if err != nil {
		return *new(*big.Int), err
	}

	out0 := *abi.ConvertType(out[0], new(*big.Int)).(**big.Int)

	return out0, err

}

// BalanceOf is a free data retrieval call binding the contract method 0x70a08231.
//
// Solidity: function balanceOf(address account) view returns(uint256)
func (_Vault *VaultSession) BalanceOf(account common.Address) (*big.Int, error) {
	return _Vault.Contract.BalanceOf(&_Vault.CallOpts, account)
}

// BalanceOf is a free data retrieval call binding the contract method 0x70a08231.
//
// Solidity: function balanceOf(address account) view returns(uint256)
func (_Vault *VaultCallerSession) BalanceOf(account common.Address) (*big.Int, error) {
	return _Vault.Contract.BalanceOf(&_Vault.CallOpts, account)
}

// Decimals is a free data retrieval call binding the contract method 0x313ce567.
//
// Solidity: function decimals() view returns(uint8)
func (_Vault *VaultCaller) Decimals(opts *bind.CallOpts) (uint8, error) {
	var out []interface{}
	err := _Vault.contract.Call(opts, &out, "decimals")

	if err != nil {
		return *new(uint8), err
	}

	out0 := *abi.ConvertType(out[0], new(uint8)).(*uint8)

	return out0, err

}

// Decimals is a free data retrieval call binding the contract method 0x313ce567.
//
// Solidity: function decimals() view returns(uint8)
func (_Vault *VaultSession) Decimals() (uint8, error) {
	return _Vault.Contract.Decimals(&_Vault.CallOpts)
}

// Decimals is a free data retrieval call binding the contract method 0x313ce567.
//
// Solidity: function decimals() view returns(uint8)
func (_Vault *VaultCallerSession) Decimals() (uint8, error) {
	return _Vault.Contract.Decimals(&_Vault.CallOpts)
}

// GetUserStaked is a free data retrieval call binding the contract method 0xdac3fc3f.
//
// Solidity: function getUserStaked(address account) view returns(uint256)
func (_Vault *VaultCaller) GetUserStaked(opts *bind.CallOpts, account common.Address) (*big.Int, error) {
	var out []interface{}
	err := _Vault.contract.Call(opts, &out, "getUserStaked", account)

	if err != nil {
		return *new(*big.Int), err
	}

	out0 := *abi.ConvertType(out[0], new(*big.Int)).(**big.Int)

	return out0, err

}

// GetUserStaked is a free data retrieval call binding the contract method 0xdac3fc3f.
//
// Solidity: function getUserStaked(address account) view returns(uint256)
func (_Vault *VaultSession) GetUserStaked(account common.Address) (*big.Int, error) {
	return _Vault.Contract.GetUserStaked(&_Vault.CallOpts, account)
}

// GetUserStaked is a free data retrieval call binding the contract method 0xdac3fc3f.
//
// Solidity: function getUserStaked(address account) view returns(uint256)
func (_Vault *VaultCallerSession) GetUserStaked(account common.Address) (*big.Int, error) {
	return _Vault.Contract.GetUserStaked(&_Vault.CallOpts, account)
}

// MaxStakeAmount is a free data retrieval call binding the contract method 0x5d80ca32.
//
// Solidity: function maxStakeAmount() view returns(uint256)
func (_Vault *VaultCaller) MaxStakeAmount(opts *bind.CallOpts) (*big.Int, error) {
	var out []interface{}
	err := _Vault.contract.Call(opts, &out, "maxStakeAmount")

	if err != nil {
		return *new(*big.Int), err
	}

	out0 := *abi.ConvertType(out[0], new(*big.Int)).(**big.Int)

	return out0, err

}

// MaxStakeAmount is a free data retrieval call binding the contract method 0x5d80ca32.
//
// Solidity: function maxStakeAmount() view returns(uint256)
func (_Vault *VaultSession) MaxStakeAmount() (*big.Int, error) {
	return _Vault.Contract.MaxStakeAmount(&_Vault.CallOpts)
}

// MaxStakeAmount is a free data retrieval call binding the contract method 0x5d80ca32.
//
// Solidity: function maxStakeAmount() view returns(uint256)
func (_Vault *VaultCallerSession) MaxStakeAmount() (*big.Int, error) {
	return _Vault.Contract.MaxStakeAmount(&_Vault.CallOpts)
}

// MembersLength is a free data retrieval call binding the contract method 0x0f027c67.
//
// Solidity: function membersLength() view returns(uint256)
func (_Vault *VaultCaller) MembersLength(opts *bind.CallOpts) (*big.Int, error) {
	var out []interface{}
	err := _Vault.contract.Call(opts, &out, "membersLength")

	if err != nil {
		return *new(*big.Int), err
	}

	out0 := *abi.ConvertType(out[0], new(*big.Int)).(**big.Int)

	return out0, err

}

// MembersLength is a free data retrieval call binding the contract method 0x0f027c67.
//
// Solidity: function membersLength() view returns(uint256)
func (_Vault *VaultSession) MembersLength() (*big.Int, error) {
	return _Vault.Contract.MembersLength(&_Vault.CallOpts)
}

// MembersLength is a free data retrieval call binding the contract method 0x0f027c67.
//
// Solidity: function membersLength() view returns(uint256)
func (_Vault *VaultCallerSession) MembersLength() (*big.Int, error) {
	return _Vault.Contract.MembersLength(&_Vault.CallOpts)
}

// MinStakeAmount is a free data retrieval call binding the contract method 0xf1887684.
//
// Solidity: function minStakeAmount() view returns(uint256)
func (_Vault *VaultCaller) MinStakeAmount(opts *bind.CallOpts) (*big.Int, error) {
	var out []interface{}
	err := _Vault.contract.Call(opts, &out, "minStakeAmount")

	if err != nil {
		return *new(*big.Int), err
	}

	out0 := *abi.ConvertType(out[0], new(*big.Int)).(**big.Int)

	return out0, err

}

// MinStakeAmount is a free data retrieval call binding the contract method 0xf1887684.
//
// Solidity: function minStakeAmount() view returns(uint256)
func (_Vault *VaultSession) MinStakeAmount() (*big.Int, error) {
	return _Vault.Contract.MinStakeAmount(&_Vault.CallOpts)
}

// MinStakeAmount is a free data retrieval call binding the contract method 0xf1887684.
//
// Solidity: function minStakeAmount() view returns(uint256)
func (_Vault *VaultCallerSession) MinStakeAmount() (*big.Int, error) {
	return _Vault.Contract.MinStakeAmount(&_Vault.CallOpts)
}

// Name is a free data retrieval call binding the contract method 0x06fdde03.
//
// Solidity: function name() view returns(string)
func (_Vault *VaultCaller) Name(opts *bind.CallOpts) (string, error) {
	var out []interface{}
	err := _Vault.contract.Call(opts, &out, "name")

	if err != nil {
		return *new(string), err
	}

	out0 := *abi.ConvertType(out[0], new(string)).(*string)

	return out0, err

}

// Name is a free data retrieval call binding the contract method 0x06fdde03.
//
// Solidity: function name() view returns(string)
func (_Vault *VaultSession) Name() (string, error) {
	return _Vault.Contract.Name(&_Vault.CallOpts)
}

// Name is a free data retrieval call binding the contract method 0x06fdde03.
//
// Solidity: function name() view returns(string)
func (_Vault *VaultCallerSession) Name() (string, error) {
	return _Vault.Contract.Name(&_Vault.CallOpts)
}

// Owner is a free data retrieval call binding the contract method 0x8da5cb5b.
//
// Solidity: function owner() view returns(address)
func (_Vault *VaultCaller) Owner(opts *bind.CallOpts) (common.Address, error) {
	var out []interface{}
	err := _Vault.contract.Call(opts, &out, "owner")

	if err != nil {
		return *new(common.Address), err
	}

	out0 := *abi.ConvertType(out[0], new(common.Address)).(*common.Address)

	return out0, err

}

// Owner is a free data retrieval call binding the contract method 0x8da5cb5b.
//
// Solidity: function owner() view returns(address)
func (_Vault *VaultSession) Owner() (common.Address, error) {
	return _Vault.Contract.Owner(&_Vault.CallOpts)
}

// Owner is a free data retrieval call binding the contract method 0x8da5cb5b.
//
// Solidity: function owner() view returns(address)
func (_Vault *VaultCallerSession) Owner() (common.Address, error) {
	return _Vault.Contract.Owner(&_Vault.CallOpts)
}

// Paused is a free data retrieval call binding the contract method 0x5c975abb.
//
// Solidity: function paused() view returns(bool)
func (_Vault *VaultCaller) Paused(opts *bind.CallOpts) (bool, error) {
	var out []interface{}
	err := _Vault.contract.Call(opts, &out, "paused")

	if err != nil {
		return *new(bool), err
	}

	out0 := *abi.ConvertType(out[0], new(bool)).(*bool)

	return out0, err

}

// Paused is a free data retrieval call binding the contract method 0x5c975abb.
//
// Solidity: function paused() view returns(bool)
func (_Vault *VaultSession) Paused() (bool, error) {
	return _Vault.Contract.Paused(&_Vault.CallOpts)
}

// Paused is a free data retrieval call binding the contract method 0x5c975abb.
//
// Solidity: function paused() view returns(bool)
func (_Vault *VaultCallerSession) Paused() (bool, error) {
	return _Vault.Contract.Paused(&_Vault.CallOpts)
}

// Symbol is a free data retrieval call binding the contract method 0x95d89b41.
//
// Solidity: function symbol() view returns(string)
func (_Vault *VaultCaller) Symbol(opts *bind.CallOpts) (string, error) {
	var out []interface{}
	err := _Vault.contract.Call(opts, &out, "symbol")

	if err != nil {
		return *new(string), err
	}

	out0 := *abi.ConvertType(out[0], new(string)).(*string)

	return out0, err

}

// Symbol is a free data retrieval call binding the contract method 0x95d89b41.
//
// Solidity: function symbol() view returns(string)
func (_Vault *VaultSession) Symbol() (string, error) {
	return _Vault.Contract.Symbol(&_Vault.CallOpts)
}

// Symbol is a free data retrieval call binding the contract method 0x95d89b41.
//
// Solidity: function symbol() view returns(string)
func (_Vault *VaultCallerSession) Symbol() (string, error) {
	return _Vault.Contract.Symbol(&_Vault.CallOpts)
}

// TotalSupply is a free data retrieval call binding the contract method 0x18160ddd.
//
// Solidity: function totalSupply() view returns(uint256)
func (_Vault *VaultCaller) TotalSupply(opts *bind.CallOpts) (*big.Int, error) {
	var out []interface{}
	err := _Vault.contract.Call(opts, &out, "totalSupply")

	if err != nil {
		return *new(*big.Int), err
	}

	out0 := *abi.ConvertType(out[0], new(*big.Int)).(**big.Int)

	return out0, err

}

// TotalSupply is a free data retrieval call binding the contract method 0x18160ddd.
//
// Solidity: function totalSupply() view returns(uint256)
func (_Vault *VaultSession) TotalSupply() (*big.Int, error) {
	return _Vault.Contract.TotalSupply(&_Vault.CallOpts)
}

// TotalSupply is a free data retrieval call binding the contract method 0x18160ddd.
//
// Solidity: function totalSupply() view returns(uint256)
func (_Vault *VaultCallerSession) TotalSupply() (*big.Int, error) {
	return _Vault.Contract.TotalSupply(&_Vault.CallOpts)
}

// VaultBalance is a free data retrieval call binding the contract method 0x0bf6cc08.
//
// Solidity: function vaultBalance() view returns(uint256)
func (_Vault *VaultCaller) VaultBalance(opts *bind.CallOpts) (*big.Int, error) {
	var out []interface{}
	err := _Vault.contract.Call(opts, &out, "vaultBalance")

	if err != nil {
		return *new(*big.Int), err
	}

	out0 := *abi.ConvertType(out[0], new(*big.Int)).(**big.Int)

	return out0, err

}

// VaultBalance is a free data retrieval call binding the contract method 0x0bf6cc08.
//
// Solidity: function vaultBalance() view returns(uint256)
func (_Vault *VaultSession) VaultBalance() (*big.Int, error) {
	return _Vault.Contract.VaultBalance(&_Vault.CallOpts)
}

// VaultBalance is a free data retrieval call binding the contract method 0x0bf6cc08.
//
// Solidity: function vaultBalance() view returns(uint256)
func (_Vault *VaultCallerSession) VaultBalance() (*big.Int, error) {
	return _Vault.Contract.VaultBalance(&_Vault.CallOpts)
}

// VaultInfo is a free data retrieval call binding the contract method 0x501ec738.
//
// Solidity: function vaultInfo() view returns(address admin, address pool, address tokenSpin)
func (_Vault *VaultCaller) VaultInfo(opts *bind.CallOpts) (struct {
	Admin     common.Address
	Pool      common.Address
	TokenSpin common.Address
}, error) {
	var out []interface{}
	err := _Vault.contract.Call(opts, &out, "vaultInfo")

	outstruct := new(struct {
		Admin     common.Address
		Pool      common.Address
		TokenSpin common.Address
	})
	if err != nil {
		return *outstruct, err
	}

	outstruct.Admin = *abi.ConvertType(out[0], new(common.Address)).(*common.Address)
	outstruct.Pool = *abi.ConvertType(out[1], new(common.Address)).(*common.Address)
	outstruct.TokenSpin = *abi.ConvertType(out[2], new(common.Address)).(*common.Address)

	return *outstruct, err

}

// VaultInfo is a free data retrieval call binding the contract method 0x501ec738.
//
// Solidity: function vaultInfo() view returns(address admin, address pool, address tokenSpin)
func (_Vault *VaultSession) VaultInfo() (struct {
	Admin     common.Address
	Pool      common.Address
	TokenSpin common.Address
}, error) {
	return _Vault.Contract.VaultInfo(&_Vault.CallOpts)
}

// VaultInfo is a free data retrieval call binding the contract method 0x501ec738.
//
// Solidity: function vaultInfo() view returns(address admin, address pool, address tokenSpin)
func (_Vault *VaultCallerSession) VaultInfo() (struct {
	Admin     common.Address
	Pool      common.Address
	TokenSpin common.Address
}, error) {
	return _Vault.Contract.VaultInfo(&_Vault.CallOpts)
}

// Approve is a paid mutator transaction binding the contract method 0x095ea7b3.
//
// Solidity: function approve(address spender, uint256 amount) returns(bool)
func (_Vault *VaultTransactor) Approve(opts *bind.TransactOpts, spender common.Address, amount *big.Int) (*types.Transaction, error) {
	return _Vault.contract.Transact(opts, "approve", spender, amount)
}

// Approve is a paid mutator transaction binding the contract method 0x095ea7b3.
//
// Solidity: function approve(address spender, uint256 amount) returns(bool)
func (_Vault *VaultSession) Approve(spender common.Address, amount *big.Int) (*types.Transaction, error) {
	return _Vault.Contract.Approve(&_Vault.TransactOpts, spender, amount)
}

// Approve is a paid mutator transaction binding the contract method 0x095ea7b3.
//
// Solidity: function approve(address spender, uint256 amount) returns(bool)
func (_Vault *VaultTransactorSession) Approve(spender common.Address, amount *big.Int) (*types.Transaction, error) {
	return _Vault.Contract.Approve(&_Vault.TransactOpts, spender, amount)
}

// CreateIGO is a paid mutator transaction binding the contract method 0x62ee810d.
//
// Solidity: function createIGO(string _gameName, uint256 _totalDollars, address _paymentToken, uint256 _price, uint256 _priceDecimal, uint256 _duration, uint256 _multiplier) returns()
func (_Vault *VaultTransactor) CreateIGO(opts *bind.TransactOpts, _gameName string, _totalDollars *big.Int, _paymentToken common.Address, _price *big.Int, _priceDecimal *big.Int, _duration *big.Int, _multiplier *big.Int) (*types.Transaction, error) {
	return _Vault.contract.Transact(opts, "createIGO", _gameName, _totalDollars, _paymentToken, _price, _priceDecimal, _duration, _multiplier)
}

// CreateIGO is a paid mutator transaction binding the contract method 0x62ee810d.
//
// Solidity: function createIGO(string _gameName, uint256 _totalDollars, address _paymentToken, uint256 _price, uint256 _priceDecimal, uint256 _duration, uint256 _multiplier) returns()
func (_Vault *VaultSession) CreateIGO(_gameName string, _totalDollars *big.Int, _paymentToken common.Address, _price *big.Int, _priceDecimal *big.Int, _duration *big.Int, _multiplier *big.Int) (*types.Transaction, error) {
	return _Vault.Contract.CreateIGO(&_Vault.TransactOpts, _gameName, _totalDollars, _paymentToken, _price, _priceDecimal, _duration, _multiplier)
}

// CreateIGO is a paid mutator transaction binding the contract method 0x62ee810d.
//
// Solidity: function createIGO(string _gameName, uint256 _totalDollars, address _paymentToken, uint256 _price, uint256 _priceDecimal, uint256 _duration, uint256 _multiplier) returns()
func (_Vault *VaultTransactorSession) CreateIGO(_gameName string, _totalDollars *big.Int, _paymentToken common.Address, _price *big.Int, _priceDecimal *big.Int, _duration *big.Int, _multiplier *big.Int) (*types.Transaction, error) {
	return _Vault.Contract.CreateIGO(&_Vault.TransactOpts, _gameName, _totalDollars, _paymentToken, _price, _priceDecimal, _duration, _multiplier)
}

// DecreaseAllowance is a paid mutator transaction binding the contract method 0xa457c2d7.
//
// Solidity: function decreaseAllowance(address spender, uint256 subtractedValue) returns(bool)
func (_Vault *VaultTransactor) DecreaseAllowance(opts *bind.TransactOpts, spender common.Address, subtractedValue *big.Int) (*types.Transaction, error) {
	return _Vault.contract.Transact(opts, "decreaseAllowance", spender, subtractedValue)
}

// DecreaseAllowance is a paid mutator transaction binding the contract method 0xa457c2d7.
//
// Solidity: function decreaseAllowance(address spender, uint256 subtractedValue) returns(bool)
func (_Vault *VaultSession) DecreaseAllowance(spender common.Address, subtractedValue *big.Int) (*types.Transaction, error) {
	return _Vault.Contract.DecreaseAllowance(&_Vault.TransactOpts, spender, subtractedValue)
}

// DecreaseAllowance is a paid mutator transaction binding the contract method 0xa457c2d7.
//
// Solidity: function decreaseAllowance(address spender, uint256 subtractedValue) returns(bool)
func (_Vault *VaultTransactorSession) DecreaseAllowance(spender common.Address, subtractedValue *big.Int) (*types.Transaction, error) {
	return _Vault.Contract.DecreaseAllowance(&_Vault.TransactOpts, spender, subtractedValue)
}

// Deposit is a paid mutator transaction binding the contract method 0xb6b55f25.
//
// Solidity: function deposit(uint256 _amount) returns()
func (_Vault *VaultTransactor) Deposit(opts *bind.TransactOpts, _amount *big.Int) (*types.Transaction, error) {
	return _Vault.contract.Transact(opts, "deposit", _amount)
}

// Deposit is a paid mutator transaction binding the contract method 0xb6b55f25.
//
// Solidity: function deposit(uint256 _amount) returns()
func (_Vault *VaultSession) Deposit(_amount *big.Int) (*types.Transaction, error) {
	return _Vault.Contract.Deposit(&_Vault.TransactOpts, _amount)
}

// Deposit is a paid mutator transaction binding the contract method 0xb6b55f25.
//
// Solidity: function deposit(uint256 _amount) returns()
func (_Vault *VaultTransactorSession) Deposit(_amount *big.Int) (*types.Transaction, error) {
	return _Vault.Contract.Deposit(&_Vault.TransactOpts, _amount)
}

// IncreaseAllowance is a paid mutator transaction binding the contract method 0x39509351.
//
// Solidity: function increaseAllowance(address spender, uint256 addedValue) returns(bool)
func (_Vault *VaultTransactor) IncreaseAllowance(opts *bind.TransactOpts, spender common.Address, addedValue *big.Int) (*types.Transaction, error) {
	return _Vault.contract.Transact(opts, "increaseAllowance", spender, addedValue)
}

// IncreaseAllowance is a paid mutator transaction binding the contract method 0x39509351.
//
// Solidity: function increaseAllowance(address spender, uint256 addedValue) returns(bool)
func (_Vault *VaultSession) IncreaseAllowance(spender common.Address, addedValue *big.Int) (*types.Transaction, error) {
	return _Vault.Contract.IncreaseAllowance(&_Vault.TransactOpts, spender, addedValue)
}

// IncreaseAllowance is a paid mutator transaction binding the contract method 0x39509351.
//
// Solidity: function increaseAllowance(address spender, uint256 addedValue) returns(bool)
func (_Vault *VaultTransactorSession) IncreaseAllowance(spender common.Address, addedValue *big.Int) (*types.Transaction, error) {
	return _Vault.Contract.IncreaseAllowance(&_Vault.TransactOpts, spender, addedValue)
}

// MigrateBalances is a paid mutator transaction binding the contract method 0xb2b44167.
//
// Solidity: function migrateBalances() returns()
func (_Vault *VaultTransactor) MigrateBalances(opts *bind.TransactOpts) (*types.Transaction, error) {
	return _Vault.contract.Transact(opts, "migrateBalances")
}

// MigrateBalances is a paid mutator transaction binding the contract method 0xb2b44167.
//
// Solidity: function migrateBalances() returns()
func (_Vault *VaultSession) MigrateBalances() (*types.Transaction, error) {
	return _Vault.Contract.MigrateBalances(&_Vault.TransactOpts)
}

// MigrateBalances is a paid mutator transaction binding the contract method 0xb2b44167.
//
// Solidity: function migrateBalances() returns()
func (_Vault *VaultTransactorSession) MigrateBalances() (*types.Transaction, error) {
	return _Vault.Contract.MigrateBalances(&_Vault.TransactOpts)
}

// NotifyVesting is a paid mutator transaction binding the contract method 0x8b763a42.
//
// Solidity: function notifyVesting(address _igo, uint256 _percentage) returns()
func (_Vault *VaultTransactor) NotifyVesting(opts *bind.TransactOpts, _igo common.Address, _percentage *big.Int) (*types.Transaction, error) {
	return _Vault.contract.Transact(opts, "notifyVesting", _igo, _percentage)
}

// NotifyVesting is a paid mutator transaction binding the contract method 0x8b763a42.
//
// Solidity: function notifyVesting(address _igo, uint256 _percentage) returns()
func (_Vault *VaultSession) NotifyVesting(_igo common.Address, _percentage *big.Int) (*types.Transaction, error) {
	return _Vault.Contract.NotifyVesting(&_Vault.TransactOpts, _igo, _percentage)
}

// NotifyVesting is a paid mutator transaction binding the contract method 0x8b763a42.
//
// Solidity: function notifyVesting(address _igo, uint256 _percentage) returns()
func (_Vault *VaultTransactorSession) NotifyVesting(_igo common.Address, _percentage *big.Int) (*types.Transaction, error) {
	return _Vault.Contract.NotifyVesting(&_Vault.TransactOpts, _igo, _percentage)
}

// Pause is a paid mutator transaction binding the contract method 0x8456cb59.
//
// Solidity: function pause() returns()
func (_Vault *VaultTransactor) Pause(opts *bind.TransactOpts) (*types.Transaction, error) {
	return _Vault.contract.Transact(opts, "pause")
}

// Pause is a paid mutator transaction binding the contract method 0x8456cb59.
//
// Solidity: function pause() returns()
func (_Vault *VaultSession) Pause() (*types.Transaction, error) {
	return _Vault.Contract.Pause(&_Vault.TransactOpts)
}

// Pause is a paid mutator transaction binding the contract method 0x8456cb59.
//
// Solidity: function pause() returns()
func (_Vault *VaultTransactorSession) Pause() (*types.Transaction, error) {
	return _Vault.Contract.Pause(&_Vault.TransactOpts)
}

// RenounceOwnership is a paid mutator transaction binding the contract method 0x715018a6.
//
// Solidity: function renounceOwnership() returns()
func (_Vault *VaultTransactor) RenounceOwnership(opts *bind.TransactOpts) (*types.Transaction, error) {
	return _Vault.contract.Transact(opts, "renounceOwnership")
}

// RenounceOwnership is a paid mutator transaction binding the contract method 0x715018a6.
//
// Solidity: function renounceOwnership() returns()
func (_Vault *VaultSession) RenounceOwnership() (*types.Transaction, error) {
	return _Vault.Contract.RenounceOwnership(&_Vault.TransactOpts)
}

// RenounceOwnership is a paid mutator transaction binding the contract method 0x715018a6.
//
// Solidity: function renounceOwnership() returns()
func (_Vault *VaultTransactorSession) RenounceOwnership() (*types.Transaction, error) {
	return _Vault.Contract.RenounceOwnership(&_Vault.TransactOpts)
}

// SetBatchSize is a paid mutator transaction binding the contract method 0x576f35e3.
//
// Solidity: function setBatchSize(uint256 _batchSize) returns()
func (_Vault *VaultTransactor) SetBatchSize(opts *bind.TransactOpts, _batchSize *big.Int) (*types.Transaction, error) {
	return _Vault.contract.Transact(opts, "setBatchSize", _batchSize)
}

// SetBatchSize is a paid mutator transaction binding the contract method 0x576f35e3.
//
// Solidity: function setBatchSize(uint256 _batchSize) returns()
func (_Vault *VaultSession) SetBatchSize(_batchSize *big.Int) (*types.Transaction, error) {
	return _Vault.Contract.SetBatchSize(&_Vault.TransactOpts, _batchSize)
}

// SetBatchSize is a paid mutator transaction binding the contract method 0x576f35e3.
//
// Solidity: function setBatchSize(uint256 _batchSize) returns()
func (_Vault *VaultTransactorSession) SetBatchSize(_batchSize *big.Int) (*types.Transaction, error) {
	return _Vault.Contract.SetBatchSize(&_Vault.TransactOpts, _batchSize)
}

// SetPeriods is a paid mutator transaction binding the contract method 0x70adb515.
//
// Solidity: function setPeriods(address _igo, uint256 _allocationTime, uint256 _publicTime) returns()
func (_Vault *VaultTransactor) SetPeriods(opts *bind.TransactOpts, _igo common.Address, _allocationTime *big.Int, _publicTime *big.Int) (*types.Transaction, error) {
	return _Vault.contract.Transact(opts, "setPeriods", _igo, _allocationTime, _publicTime)
}

// SetPeriods is a paid mutator transaction binding the contract method 0x70adb515.
//
// Solidity: function setPeriods(address _igo, uint256 _allocationTime, uint256 _publicTime) returns()
func (_Vault *VaultSession) SetPeriods(_igo common.Address, _allocationTime *big.Int, _publicTime *big.Int) (*types.Transaction, error) {
	return _Vault.Contract.SetPeriods(&_Vault.TransactOpts, _igo, _allocationTime, _publicTime)
}

// SetPeriods is a paid mutator transaction binding the contract method 0x70adb515.
//
// Solidity: function setPeriods(address _igo, uint256 _allocationTime, uint256 _publicTime) returns()
func (_Vault *VaultTransactorSession) SetPeriods(_igo common.Address, _allocationTime *big.Int, _publicTime *big.Int) (*types.Transaction, error) {
	return _Vault.Contract.SetPeriods(&_Vault.TransactOpts, _igo, _allocationTime, _publicTime)
}

// SetToken is a paid mutator transaction binding the contract method 0xa438f000.
//
// Solidity: function setToken(address _igo, address _token, uint256 _decimal) returns()
func (_Vault *VaultTransactor) SetToken(opts *bind.TransactOpts, _igo common.Address, _token common.Address, _decimal *big.Int) (*types.Transaction, error) {
	return _Vault.contract.Transact(opts, "setToken", _igo, _token, _decimal)
}

// SetToken is a paid mutator transaction binding the contract method 0xa438f000.
//
// Solidity: function setToken(address _igo, address _token, uint256 _decimal) returns()
func (_Vault *VaultSession) SetToken(_igo common.Address, _token common.Address, _decimal *big.Int) (*types.Transaction, error) {
	return _Vault.Contract.SetToken(&_Vault.TransactOpts, _igo, _token, _decimal)
}

// SetToken is a paid mutator transaction binding the contract method 0xa438f000.
//
// Solidity: function setToken(address _igo, address _token, uint256 _decimal) returns()
func (_Vault *VaultTransactorSession) SetToken(_igo common.Address, _token common.Address, _decimal *big.Int) (*types.Transaction, error) {
	return _Vault.Contract.SetToken(&_Vault.TransactOpts, _igo, _token, _decimal)
}

// Start is a paid mutator transaction binding the contract method 0xbe9a6555.
//
// Solidity: function start() returns()
func (_Vault *VaultTransactor) Start(opts *bind.TransactOpts) (*types.Transaction, error) {
	return _Vault.contract.Transact(opts, "start")
}

// Start is a paid mutator transaction binding the contract method 0xbe9a6555.
//
// Solidity: function start() returns()
func (_Vault *VaultSession) Start() (*types.Transaction, error) {
	return _Vault.Contract.Start(&_Vault.TransactOpts)
}

// Start is a paid mutator transaction binding the contract method 0xbe9a6555.
//
// Solidity: function start() returns()
func (_Vault *VaultTransactorSession) Start() (*types.Transaction, error) {
	return _Vault.Contract.Start(&_Vault.TransactOpts)
}

// Transfer is a paid mutator transaction binding the contract method 0xa9059cbb.
//
// Solidity: function transfer(address recipient, uint256 amount) returns(bool)
func (_Vault *VaultTransactor) Transfer(opts *bind.TransactOpts, recipient common.Address, amount *big.Int) (*types.Transaction, error) {
	return _Vault.contract.Transact(opts, "transfer", recipient, amount)
}

// Transfer is a paid mutator transaction binding the contract method 0xa9059cbb.
//
// Solidity: function transfer(address recipient, uint256 amount) returns(bool)
func (_Vault *VaultSession) Transfer(recipient common.Address, amount *big.Int) (*types.Transaction, error) {
	return _Vault.Contract.Transfer(&_Vault.TransactOpts, recipient, amount)
}

// Transfer is a paid mutator transaction binding the contract method 0xa9059cbb.
//
// Solidity: function transfer(address recipient, uint256 amount) returns(bool)
func (_Vault *VaultTransactorSession) Transfer(recipient common.Address, amount *big.Int) (*types.Transaction, error) {
	return _Vault.Contract.Transfer(&_Vault.TransactOpts, recipient, amount)
}

// TransferFrom is a paid mutator transaction binding the contract method 0x23b872dd.
//
// Solidity: function transferFrom(address sender, address recipient, uint256 amount) returns(bool)
func (_Vault *VaultTransactor) TransferFrom(opts *bind.TransactOpts, sender common.Address, recipient common.Address, amount *big.Int) (*types.Transaction, error) {
	return _Vault.contract.Transact(opts, "transferFrom", sender, recipient, amount)
}

// TransferFrom is a paid mutator transaction binding the contract method 0x23b872dd.
//
// Solidity: function transferFrom(address sender, address recipient, uint256 amount) returns(bool)
func (_Vault *VaultSession) TransferFrom(sender common.Address, recipient common.Address, amount *big.Int) (*types.Transaction, error) {
	return _Vault.Contract.TransferFrom(&_Vault.TransactOpts, sender, recipient, amount)
}

// TransferFrom is a paid mutator transaction binding the contract method 0x23b872dd.
//
// Solidity: function transferFrom(address sender, address recipient, uint256 amount) returns(bool)
func (_Vault *VaultTransactorSession) TransferFrom(sender common.Address, recipient common.Address, amount *big.Int) (*types.Transaction, error) {
	return _Vault.Contract.TransferFrom(&_Vault.TransactOpts, sender, recipient, amount)
}

// TransferOwnership is a paid mutator transaction binding the contract method 0xf2fde38b.
//
// Solidity: function transferOwnership(address newOwner) returns()
func (_Vault *VaultTransactor) TransferOwnership(opts *bind.TransactOpts, newOwner common.Address) (*types.Transaction, error) {
	return _Vault.contract.Transact(opts, "transferOwnership", newOwner)
}

// TransferOwnership is a paid mutator transaction binding the contract method 0xf2fde38b.
//
// Solidity: function transferOwnership(address newOwner) returns()
func (_Vault *VaultSession) TransferOwnership(newOwner common.Address) (*types.Transaction, error) {
	return _Vault.Contract.TransferOwnership(&_Vault.TransactOpts, newOwner)
}

// TransferOwnership is a paid mutator transaction binding the contract method 0xf2fde38b.
//
// Solidity: function transferOwnership(address newOwner) returns()
func (_Vault *VaultTransactorSession) TransferOwnership(newOwner common.Address) (*types.Transaction, error) {
	return _Vault.Contract.TransferOwnership(&_Vault.TransactOpts, newOwner)
}

// Unpause is a paid mutator transaction binding the contract method 0x3f4ba83a.
//
// Solidity: function unpause() returns()
func (_Vault *VaultTransactor) Unpause(opts *bind.TransactOpts) (*types.Transaction, error) {
	return _Vault.contract.Transact(opts, "unpause")
}

// Unpause is a paid mutator transaction binding the contract method 0x3f4ba83a.
//
// Solidity: function unpause() returns()
func (_Vault *VaultSession) Unpause() (*types.Transaction, error) {
	return _Vault.Contract.Unpause(&_Vault.TransactOpts)
}

// Unpause is a paid mutator transaction binding the contract method 0x3f4ba83a.
//
// Solidity: function unpause() returns()
func (_Vault *VaultTransactorSession) Unpause() (*types.Transaction, error) {
	return _Vault.Contract.Unpause(&_Vault.TransactOpts)
}

// Withdraw is a paid mutator transaction binding the contract method 0x3ccfd60b.
//
// Solidity: function withdraw() returns()
func (_Vault *VaultTransactor) Withdraw(opts *bind.TransactOpts) (*types.Transaction, error) {
	return _Vault.contract.Transact(opts, "withdraw")
}

// Withdraw is a paid mutator transaction binding the contract method 0x3ccfd60b.
//
// Solidity: function withdraw() returns()
func (_Vault *VaultSession) Withdraw() (*types.Transaction, error) {
	return _Vault.Contract.Withdraw(&_Vault.TransactOpts)
}

// Withdraw is a paid mutator transaction binding the contract method 0x3ccfd60b.
//
// Solidity: function withdraw() returns()
func (_Vault *VaultTransactorSession) Withdraw() (*types.Transaction, error) {
	return _Vault.Contract.Withdraw(&_Vault.TransactOpts)
}

// WithdrawIGOFunds is a paid mutator transaction binding the contract method 0xc8987bc8.
//
// Solidity: function withdrawIGOFunds(address _igo, uint256 token) returns()
func (_Vault *VaultTransactor) WithdrawIGOFunds(opts *bind.TransactOpts, _igo common.Address, token *big.Int) (*types.Transaction, error) {
	return _Vault.contract.Transact(opts, "withdrawIGOFunds", _igo, token)
}

// WithdrawIGOFunds is a paid mutator transaction binding the contract method 0xc8987bc8.
//
// Solidity: function withdrawIGOFunds(address _igo, uint256 token) returns()
func (_Vault *VaultSession) WithdrawIGOFunds(_igo common.Address, token *big.Int) (*types.Transaction, error) {
	return _Vault.Contract.WithdrawIGOFunds(&_Vault.TransactOpts, _igo, token)
}

// WithdrawIGOFunds is a paid mutator transaction binding the contract method 0xc8987bc8.
//
// Solidity: function withdrawIGOFunds(address _igo, uint256 token) returns()
func (_Vault *VaultTransactorSession) WithdrawIGOFunds(_igo common.Address, token *big.Int) (*types.Transaction, error) {
	return _Vault.Contract.WithdrawIGOFunds(&_Vault.TransactOpts, _igo, token)
}

// VaultApprovalIterator is returned from FilterApproval and is used to iterate over the raw logs and unpacked data for Approval events raised by the Vault contract.
type VaultApprovalIterator struct {
	Event *VaultApproval // Event containing the contract specifics and raw log

	contract *bind.BoundContract // Generic contract to use for unpacking event data
	event    string              // Event name to use for unpacking event data

	logs chan types.Log        // Log channel receiving the found contract events
	sub  ethereum.Subscription // Subscription for errors, completion and termination
	done bool                  // Whether the subscription completed delivering logs
	fail error                 // Occurred error to stop iteration
}

// Next advances the iterator to the subsequent event, returning whether there
// are any more events found. In case of a retrieval or parsing error, false is
// returned and Error() can be queried for the exact failure.
func (it *VaultApprovalIterator) Next() bool {
	// If the iterator failed, stop iterating
	if it.fail != nil {
		return false
	}
	// If the iterator completed, deliver directly whatever's available
	if it.done {
		select {
		case log := <-it.logs:
			it.Event = new(VaultApproval)
			if err := it.contract.UnpackLog(it.Event, it.event, log); err != nil {
				it.fail = err
				return false
			}
			it.Event.Raw = log
			return true

		default:
			return false
		}
	}
	// Iterator still in progress, wait for either a data or an error event
	select {
	case log := <-it.logs:
		it.Event = new(VaultApproval)
		if err := it.contract.UnpackLog(it.Event, it.event, log); err != nil {
			it.fail = err
			return false
		}
		it.Event.Raw = log
		return true

	case err := <-it.sub.Err():
		it.done = true
		it.fail = err
		return it.Next()
	}
}

// Error returns any retrieval or parsing error occurred during filtering.
func (it *VaultApprovalIterator) Error() error {
	return it.fail
}

// Close terminates the iteration process, releasing any pending underlying
// resources.
func (it *VaultApprovalIterator) Close() error {
	it.sub.Unsubscribe()
	return nil
}

// VaultApproval represents a Approval event raised by the Vault contract.
type VaultApproval struct {
	Owner   common.Address
	Spender common.Address
	Value   *big.Int
	Raw     types.Log // Blockchain specific contextual infos
}

// FilterApproval is a free log retrieval operation binding the contract event 0x8c5be1e5ebec7d5bd14f71427d1e84f3dd0314c0f7b2291e5b200ac8c7c3b925.
//
// Solidity: event Approval(address indexed owner, address indexed spender, uint256 value)
func (_Vault *VaultFilterer) FilterApproval(opts *bind.FilterOpts, owner []common.Address, spender []common.Address) (*VaultApprovalIterator, error) {

	var ownerRule []interface{}
	for _, ownerItem := range owner {
		ownerRule = append(ownerRule, ownerItem)
	}
	var spenderRule []interface{}
	for _, spenderItem := range spender {
		spenderRule = append(spenderRule, spenderItem)
	}

	logs, sub, err := _Vault.contract.FilterLogs(opts, "Approval", ownerRule, spenderRule)
	if err != nil {
		return nil, err
	}
	return &VaultApprovalIterator{contract: _Vault.contract, event: "Approval", logs: logs, sub: sub}, nil
}

// WatchApproval is a free log subscription operation binding the contract event 0x8c5be1e5ebec7d5bd14f71427d1e84f3dd0314c0f7b2291e5b200ac8c7c3b925.
//
// Solidity: event Approval(address indexed owner, address indexed spender, uint256 value)
func (_Vault *VaultFilterer) WatchApproval(opts *bind.WatchOpts, sink chan<- *VaultApproval, owner []common.Address, spender []common.Address) (event.Subscription, error) {

	var ownerRule []interface{}
	for _, ownerItem := range owner {
		ownerRule = append(ownerRule, ownerItem)
	}
	var spenderRule []interface{}
	for _, spenderItem := range spender {
		spenderRule = append(spenderRule, spenderItem)
	}

	logs, sub, err := _Vault.contract.WatchLogs(opts, "Approval", ownerRule, spenderRule)
	if err != nil {
		return nil, err
	}
	return event.NewSubscription(func(quit <-chan struct{}) error {
		defer sub.Unsubscribe()
		for {
			select {
			case log := <-logs:
				// New log arrived, parse the event and forward to the user
				event := new(VaultApproval)
				if err := _Vault.contract.UnpackLog(event, "Approval", log); err != nil {
					return err
				}
				event.Raw = log

				select {
				case sink <- event:
				case err := <-sub.Err():
					return err
				case <-quit:
					return nil
				}
			case err := <-sub.Err():
				return err
			case <-quit:
				return nil
			}
		}
	}), nil
}

// ParseApproval is a log parse operation binding the contract event 0x8c5be1e5ebec7d5bd14f71427d1e84f3dd0314c0f7b2291e5b200ac8c7c3b925.
//
// Solidity: event Approval(address indexed owner, address indexed spender, uint256 value)
func (_Vault *VaultFilterer) ParseApproval(log types.Log) (*VaultApproval, error) {
	event := new(VaultApproval)
	if err := _Vault.contract.UnpackLog(event, "Approval", log); err != nil {
		return nil, err
	}
	event.Raw = log
	return event, nil
}

// VaultOwnershipTransferredIterator is returned from FilterOwnershipTransferred and is used to iterate over the raw logs and unpacked data for OwnershipTransferred events raised by the Vault contract.
type VaultOwnershipTransferredIterator struct {
	Event *VaultOwnershipTransferred // Event containing the contract specifics and raw log

	contract *bind.BoundContract // Generic contract to use for unpacking event data
	event    string              // Event name to use for unpacking event data

	logs chan types.Log        // Log channel receiving the found contract events
	sub  ethereum.Subscription // Subscription for errors, completion and termination
	done bool                  // Whether the subscription completed delivering logs
	fail error                 // Occurred error to stop iteration
}

// Next advances the iterator to the subsequent event, returning whether there
// are any more events found. In case of a retrieval or parsing error, false is
// returned and Error() can be queried for the exact failure.
func (it *VaultOwnershipTransferredIterator) Next() bool {
	// If the iterator failed, stop iterating
	if it.fail != nil {
		return false
	}
	// If the iterator completed, deliver directly whatever's available
	if it.done {
		select {
		case log := <-it.logs:
			it.Event = new(VaultOwnershipTransferred)
			if err := it.contract.UnpackLog(it.Event, it.event, log); err != nil {
				it.fail = err
				return false
			}
			it.Event.Raw = log
			return true

		default:
			return false
		}
	}
	// Iterator still in progress, wait for either a data or an error event
	select {
	case log := <-it.logs:
		it.Event = new(VaultOwnershipTransferred)
		if err := it.contract.UnpackLog(it.Event, it.event, log); err != nil {
			it.fail = err
			return false
		}
		it.Event.Raw = log
		return true

	case err := <-it.sub.Err():
		it.done = true
		it.fail = err
		return it.Next()
	}
}

// Error returns any retrieval or parsing error occurred during filtering.
func (it *VaultOwnershipTransferredIterator) Error() error {
	return it.fail
}

// Close terminates the iteration process, releasing any pending underlying
// resources.
func (it *VaultOwnershipTransferredIterator) Close() error {
	it.sub.Unsubscribe()
	return nil
}

// VaultOwnershipTransferred represents a OwnershipTransferred event raised by the Vault contract.
type VaultOwnershipTransferred struct {
	PreviousOwner common.Address
	NewOwner      common.Address
	Raw           types.Log // Blockchain specific contextual infos
}

// FilterOwnershipTransferred is a free log retrieval operation binding the contract event 0x8be0079c531659141344cd1fd0a4f28419497f9722a3daafe3b4186f6b6457e0.
//
// Solidity: event OwnershipTransferred(address indexed previousOwner, address indexed newOwner)
func (_Vault *VaultFilterer) FilterOwnershipTransferred(opts *bind.FilterOpts, previousOwner []common.Address, newOwner []common.Address) (*VaultOwnershipTransferredIterator, error) {

	var previousOwnerRule []interface{}
	for _, previousOwnerItem := range previousOwner {
		previousOwnerRule = append(previousOwnerRule, previousOwnerItem)
	}
	var newOwnerRule []interface{}
	for _, newOwnerItem := range newOwner {
		newOwnerRule = append(newOwnerRule, newOwnerItem)
	}

	logs, sub, err := _Vault.contract.FilterLogs(opts, "OwnershipTransferred", previousOwnerRule, newOwnerRule)
	if err != nil {
		return nil, err
	}
	return &VaultOwnershipTransferredIterator{contract: _Vault.contract, event: "OwnershipTransferred", logs: logs, sub: sub}, nil
}

// WatchOwnershipTransferred is a free log subscription operation binding the contract event 0x8be0079c531659141344cd1fd0a4f28419497f9722a3daafe3b4186f6b6457e0.
//
// Solidity: event OwnershipTransferred(address indexed previousOwner, address indexed newOwner)
func (_Vault *VaultFilterer) WatchOwnershipTransferred(opts *bind.WatchOpts, sink chan<- *VaultOwnershipTransferred, previousOwner []common.Address, newOwner []common.Address) (event.Subscription, error) {

	var previousOwnerRule []interface{}
	for _, previousOwnerItem := range previousOwner {
		previousOwnerRule = append(previousOwnerRule, previousOwnerItem)
	}
	var newOwnerRule []interface{}
	for _, newOwnerItem := range newOwner {
		newOwnerRule = append(newOwnerRule, newOwnerItem)
	}

	logs, sub, err := _Vault.contract.WatchLogs(opts, "OwnershipTransferred", previousOwnerRule, newOwnerRule)
	if err != nil {
		return nil, err
	}
	return event.NewSubscription(func(quit <-chan struct{}) error {
		defer sub.Unsubscribe()
		for {
			select {
			case log := <-logs:
				// New log arrived, parse the event and forward to the user
				event := new(VaultOwnershipTransferred)
				if err := _Vault.contract.UnpackLog(event, "OwnershipTransferred", log); err != nil {
					return err
				}
				event.Raw = log

				select {
				case sink <- event:
				case err := <-sub.Err():
					return err
				case <-quit:
					return nil
				}
			case err := <-sub.Err():
				return err
			case <-quit:
				return nil
			}
		}
	}), nil
}

// ParseOwnershipTransferred is a log parse operation binding the contract event 0x8be0079c531659141344cd1fd0a4f28419497f9722a3daafe3b4186f6b6457e0.
//
// Solidity: event OwnershipTransferred(address indexed previousOwner, address indexed newOwner)
func (_Vault *VaultFilterer) ParseOwnershipTransferred(log types.Log) (*VaultOwnershipTransferred, error) {
	event := new(VaultOwnershipTransferred)
	if err := _Vault.contract.UnpackLog(event, "OwnershipTransferred", log); err != nil {
		return nil, err
	}
	event.Raw = log
	return event, nil
}

// VaultPausedIterator is returned from FilterPaused and is used to iterate over the raw logs and unpacked data for Paused events raised by the Vault contract.
type VaultPausedIterator struct {
	Event *VaultPaused // Event containing the contract specifics and raw log

	contract *bind.BoundContract // Generic contract to use for unpacking event data
	event    string              // Event name to use for unpacking event data

	logs chan types.Log        // Log channel receiving the found contract events
	sub  ethereum.Subscription // Subscription for errors, completion and termination
	done bool                  // Whether the subscription completed delivering logs
	fail error                 // Occurred error to stop iteration
}

// Next advances the iterator to the subsequent event, returning whether there
// are any more events found. In case of a retrieval or parsing error, false is
// returned and Error() can be queried for the exact failure.
func (it *VaultPausedIterator) Next() bool {
	// If the iterator failed, stop iterating
	if it.fail != nil {
		return false
	}
	// If the iterator completed, deliver directly whatever's available
	if it.done {
		select {
		case log := <-it.logs:
			it.Event = new(VaultPaused)
			if err := it.contract.UnpackLog(it.Event, it.event, log); err != nil {
				it.fail = err
				return false
			}
			it.Event.Raw = log
			return true

		default:
			return false
		}
	}
	// Iterator still in progress, wait for either a data or an error event
	select {
	case log := <-it.logs:
		it.Event = new(VaultPaused)
		if err := it.contract.UnpackLog(it.Event, it.event, log); err != nil {
			it.fail = err
			return false
		}
		it.Event.Raw = log
		return true

	case err := <-it.sub.Err():
		it.done = true
		it.fail = err
		return it.Next()
	}
}

// Error returns any retrieval or parsing error occurred during filtering.
func (it *VaultPausedIterator) Error() error {
	return it.fail
}

// Close terminates the iteration process, releasing any pending underlying
// resources.
func (it *VaultPausedIterator) Close() error {
	it.sub.Unsubscribe()
	return nil
}

// VaultPaused represents a Paused event raised by the Vault contract.
type VaultPaused struct {
	Account common.Address
	Raw     types.Log // Blockchain specific contextual infos
}

// FilterPaused is a free log retrieval operation binding the contract event 0x62e78cea01bee320cd4e420270b5ea74000d11b0c9f74754ebdbfc544b05a258.
//
// Solidity: event Paused(address account)
func (_Vault *VaultFilterer) FilterPaused(opts *bind.FilterOpts) (*VaultPausedIterator, error) {

	logs, sub, err := _Vault.contract.FilterLogs(opts, "Paused")
	if err != nil {
		return nil, err
	}
	return &VaultPausedIterator{contract: _Vault.contract, event: "Paused", logs: logs, sub: sub}, nil
}

// WatchPaused is a free log subscription operation binding the contract event 0x62e78cea01bee320cd4e420270b5ea74000d11b0c9f74754ebdbfc544b05a258.
//
// Solidity: event Paused(address account)
func (_Vault *VaultFilterer) WatchPaused(opts *bind.WatchOpts, sink chan<- *VaultPaused) (event.Subscription, error) {

	logs, sub, err := _Vault.contract.WatchLogs(opts, "Paused")
	if err != nil {
		return nil, err
	}
	return event.NewSubscription(func(quit <-chan struct{}) error {
		defer sub.Unsubscribe()
		for {
			select {
			case log := <-logs:
				// New log arrived, parse the event and forward to the user
				event := new(VaultPaused)
				if err := _Vault.contract.UnpackLog(event, "Paused", log); err != nil {
					return err
				}
				event.Raw = log

				select {
				case sink <- event:
				case err := <-sub.Err():
					return err
				case <-quit:
					return nil
				}
			case err := <-sub.Err():
				return err
			case <-quit:
				return nil
			}
		}
	}), nil
}

// ParsePaused is a log parse operation binding the contract event 0x62e78cea01bee320cd4e420270b5ea74000d11b0c9f74754ebdbfc544b05a258.
//
// Solidity: event Paused(address account)
func (_Vault *VaultFilterer) ParsePaused(log types.Log) (*VaultPaused, error) {
	event := new(VaultPaused)
	if err := _Vault.contract.UnpackLog(event, "Paused", log); err != nil {
		return nil, err
	}
	event.Raw = log
	return event, nil
}

// VaultTransferIterator is returned from FilterTransfer and is used to iterate over the raw logs and unpacked data for Transfer events raised by the Vault contract.
type VaultTransferIterator struct {
	Event *VaultTransfer // Event containing the contract specifics and raw log

	contract *bind.BoundContract // Generic contract to use for unpacking event data
	event    string              // Event name to use for unpacking event data

	logs chan types.Log        // Log channel receiving the found contract events
	sub  ethereum.Subscription // Subscription for errors, completion and termination
	done bool                  // Whether the subscription completed delivering logs
	fail error                 // Occurred error to stop iteration
}

// Next advances the iterator to the subsequent event, returning whether there
// are any more events found. In case of a retrieval or parsing error, false is
// returned and Error() can be queried for the exact failure.
func (it *VaultTransferIterator) Next() bool {
	// If the iterator failed, stop iterating
	if it.fail != nil {
		return false
	}
	// If the iterator completed, deliver directly whatever's available
	if it.done {
		select {
		case log := <-it.logs:
			it.Event = new(VaultTransfer)
			if err := it.contract.UnpackLog(it.Event, it.event, log); err != nil {
				it.fail = err
				return false
			}
			it.Event.Raw = log
			return true

		default:
			return false
		}
	}
	// Iterator still in progress, wait for either a data or an error event
	select {
	case log := <-it.logs:
		it.Event = new(VaultTransfer)
		if err := it.contract.UnpackLog(it.Event, it.event, log); err != nil {
			it.fail = err
			return false
		}
		it.Event.Raw = log
		return true

	case err := <-it.sub.Err():
		it.done = true
		it.fail = err
		return it.Next()
	}
}

// Error returns any retrieval or parsing error occurred during filtering.
func (it *VaultTransferIterator) Error() error {
	return it.fail
}

// Close terminates the iteration process, releasing any pending underlying
// resources.
func (it *VaultTransferIterator) Close() error {
	it.sub.Unsubscribe()
	return nil
}

// VaultTransfer represents a Transfer event raised by the Vault contract.
type VaultTransfer struct {
	From  common.Address
	To    common.Address
	Value *big.Int
	Raw   types.Log // Blockchain specific contextual infos
}

// FilterTransfer is a free log retrieval operation binding the contract event 0xddf252ad1be2c89b69c2b068fc378daa952ba7f163c4a11628f55a4df523b3ef.
//
// Solidity: event Transfer(address indexed from, address indexed to, uint256 value)
func (_Vault *VaultFilterer) FilterTransfer(opts *bind.FilterOpts, from []common.Address, to []common.Address) (*VaultTransferIterator, error) {

	var fromRule []interface{}
	for _, fromItem := range from {
		fromRule = append(fromRule, fromItem)
	}
	var toRule []interface{}
	for _, toItem := range to {
		toRule = append(toRule, toItem)
	}

	logs, sub, err := _Vault.contract.FilterLogs(opts, "Transfer", fromRule, toRule)
	if err != nil {
		return nil, err
	}
	return &VaultTransferIterator{contract: _Vault.contract, event: "Transfer", logs: logs, sub: sub}, nil
}

// WatchTransfer is a free log subscription operation binding the contract event 0xddf252ad1be2c89b69c2b068fc378daa952ba7f163c4a11628f55a4df523b3ef.
//
// Solidity: event Transfer(address indexed from, address indexed to, uint256 value)
func (_Vault *VaultFilterer) WatchTransfer(opts *bind.WatchOpts, sink chan<- *VaultTransfer, from []common.Address, to []common.Address) (event.Subscription, error) {

	var fromRule []interface{}
	for _, fromItem := range from {
		fromRule = append(fromRule, fromItem)
	}
	var toRule []interface{}
	for _, toItem := range to {
		toRule = append(toRule, toItem)
	}

	logs, sub, err := _Vault.contract.WatchLogs(opts, "Transfer", fromRule, toRule)
	if err != nil {
		return nil, err
	}
	return event.NewSubscription(func(quit <-chan struct{}) error {
		defer sub.Unsubscribe()
		for {
			select {
			case log := <-logs:
				// New log arrived, parse the event and forward to the user
				event := new(VaultTransfer)
				if err := _Vault.contract.UnpackLog(event, "Transfer", log); err != nil {
					return err
				}
				event.Raw = log

				select {
				case sink <- event:
				case err := <-sub.Err():
					return err
				case <-quit:
					return nil
				}
			case err := <-sub.Err():
				return err
			case <-quit:
				return nil
			}
		}
	}), nil
}

// ParseTransfer is a log parse operation binding the contract event 0xddf252ad1be2c89b69c2b068fc378daa952ba7f163c4a11628f55a4df523b3ef.
//
// Solidity: event Transfer(address indexed from, address indexed to, uint256 value)
func (_Vault *VaultFilterer) ParseTransfer(log types.Log) (*VaultTransfer, error) {
	event := new(VaultTransfer)
	if err := _Vault.contract.UnpackLog(event, "Transfer", log); err != nil {
		return nil, err
	}
	event.Raw = log
	return event, nil
}

// VaultUnpausedIterator is returned from FilterUnpaused and is used to iterate over the raw logs and unpacked data for Unpaused events raised by the Vault contract.
type VaultUnpausedIterator struct {
	Event *VaultUnpaused // Event containing the contract specifics and raw log

	contract *bind.BoundContract // Generic contract to use for unpacking event data
	event    string              // Event name to use for unpacking event data

	logs chan types.Log        // Log channel receiving the found contract events
	sub  ethereum.Subscription // Subscription for errors, completion and termination
	done bool                  // Whether the subscription completed delivering logs
	fail error                 // Occurred error to stop iteration
}

// Next advances the iterator to the subsequent event, returning whether there
// are any more events found. In case of a retrieval or parsing error, false is
// returned and Error() can be queried for the exact failure.
func (it *VaultUnpausedIterator) Next() bool {
	// If the iterator failed, stop iterating
	if it.fail != nil {
		return false
	}
	// If the iterator completed, deliver directly whatever's available
	if it.done {
		select {
		case log := <-it.logs:
			it.Event = new(VaultUnpaused)
			if err := it.contract.UnpackLog(it.Event, it.event, log); err != nil {
				it.fail = err
				return false
			}
			it.Event.Raw = log
			return true

		default:
			return false
		}
	}
	// Iterator still in progress, wait for either a data or an error event
	select {
	case log := <-it.logs:
		it.Event = new(VaultUnpaused)
		if err := it.contract.UnpackLog(it.Event, it.event, log); err != nil {
			it.fail = err
			return false
		}
		it.Event.Raw = log
		return true

	case err := <-it.sub.Err():
		it.done = true
		it.fail = err
		return it.Next()
	}
}

// Error returns any retrieval or parsing error occurred during filtering.
func (it *VaultUnpausedIterator) Error() error {
	return it.fail
}

// Close terminates the iteration process, releasing any pending underlying
// resources.
func (it *VaultUnpausedIterator) Close() error {
	it.sub.Unsubscribe()
	return nil
}

// VaultUnpaused represents a Unpaused event raised by the Vault contract.
type VaultUnpaused struct {
	Account common.Address
	Raw     types.Log // Blockchain specific contextual infos
}

// FilterUnpaused is a free log retrieval operation binding the contract event 0x5db9ee0a495bf2e6ff9c91a7834c1ba4fdd244a5e8aa4e537bd38aeae4b073aa.
//
// Solidity: event Unpaused(address account)
func (_Vault *VaultFilterer) FilterUnpaused(opts *bind.FilterOpts) (*VaultUnpausedIterator, error) {

	logs, sub, err := _Vault.contract.FilterLogs(opts, "Unpaused")
	if err != nil {
		return nil, err
	}
	return &VaultUnpausedIterator{contract: _Vault.contract, event: "Unpaused", logs: logs, sub: sub}, nil
}

// WatchUnpaused is a free log subscription operation binding the contract event 0x5db9ee0a495bf2e6ff9c91a7834c1ba4fdd244a5e8aa4e537bd38aeae4b073aa.
//
// Solidity: event Unpaused(address account)
func (_Vault *VaultFilterer) WatchUnpaused(opts *bind.WatchOpts, sink chan<- *VaultUnpaused) (event.Subscription, error) {

	logs, sub, err := _Vault.contract.WatchLogs(opts, "Unpaused")
	if err != nil {
		return nil, err
	}
	return event.NewSubscription(func(quit <-chan struct{}) error {
		defer sub.Unsubscribe()
		for {
			select {
			case log := <-logs:
				// New log arrived, parse the event and forward to the user
				event := new(VaultUnpaused)
				if err := _Vault.contract.UnpackLog(event, "Unpaused", log); err != nil {
					return err
				}
				event.Raw = log

				select {
				case sink <- event:
				case err := <-sub.Err():
					return err
				case <-quit:
					return nil
				}
			case err := <-sub.Err():
				return err
			case <-quit:
				return nil
			}
		}
	}), nil
}

// ParseUnpaused is a log parse operation binding the contract event 0x5db9ee0a495bf2e6ff9c91a7834c1ba4fdd244a5e8aa4e537bd38aeae4b073aa.
//
// Solidity: event Unpaused(address account)
func (_Vault *VaultFilterer) ParseUnpaused(log types.Log) (*VaultUnpaused, error) {
	event := new(VaultUnpaused)
	if err := _Vault.contract.UnpackLog(event, "Unpaused", log); err != nil {
		return nil, err
	}
	event.Raw = log
	return event, nil
}
