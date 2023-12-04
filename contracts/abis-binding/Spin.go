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

// SpinMetaData contains all meta data concerning the Spin contract.
var SpinMetaData = &bind.MetaData{
	ABI: "[{\"inputs\":[],\"stateMutability\":\"nonpayable\",\"type\":\"constructor\"},{\"anonymous\":false,\"inputs\":[{\"indexed\":true,\"internalType\":\"address\",\"name\":\"owner\",\"type\":\"address\"},{\"indexed\":true,\"internalType\":\"address\",\"name\":\"spender\",\"type\":\"address\"},{\"indexed\":false,\"internalType\":\"uint256\",\"name\":\"value\",\"type\":\"uint256\"}],\"name\":\"Approval\",\"type\":\"event\"},{\"anonymous\":false,\"inputs\":[{\"indexed\":false,\"internalType\":\"address\",\"name\":\"addr\",\"type\":\"address\"}],\"name\":\"BlacklistedAddressAdded\",\"type\":\"event\"},{\"anonymous\":false,\"inputs\":[{\"indexed\":false,\"internalType\":\"address\",\"name\":\"addr\",\"type\":\"address\"}],\"name\":\"BlacklistedAddressRemoved\",\"type\":\"event\"},{\"anonymous\":false,\"inputs\":[{\"indexed\":true,\"internalType\":\"address\",\"name\":\"previousOwner\",\"type\":\"address\"},{\"indexed\":true,\"internalType\":\"address\",\"name\":\"newOwner\",\"type\":\"address\"}],\"name\":\"OwnershipTransferred\",\"type\":\"event\"},{\"anonymous\":false,\"inputs\":[{\"indexed\":false,\"internalType\":\"address\",\"name\":\"account\",\"type\":\"address\"}],\"name\":\"Paused\",\"type\":\"event\"},{\"anonymous\":false,\"inputs\":[{\"indexed\":true,\"internalType\":\"address\",\"name\":\"from\",\"type\":\"address\"},{\"indexed\":true,\"internalType\":\"address\",\"name\":\"to\",\"type\":\"address\"},{\"indexed\":false,\"internalType\":\"uint256\",\"name\":\"value\",\"type\":\"uint256\"}],\"name\":\"Transfer\",\"type\":\"event\"},{\"anonymous\":false,\"inputs\":[{\"indexed\":false,\"internalType\":\"address\",\"name\":\"account\",\"type\":\"address\"}],\"name\":\"Unpaused\",\"type\":\"event\"},{\"inputs\":[],\"name\":\"CirculatingSupply\",\"outputs\":[{\"internalType\":\"uint256\",\"name\":\"\",\"type\":\"uint256\"}],\"stateMutability\":\"view\",\"type\":\"function\"},{\"inputs\":[{\"internalType\":\"address\",\"name\":\"addr\",\"type\":\"address\"}],\"name\":\"addAddressToBlacklist\",\"outputs\":[{\"internalType\":\"bool\",\"name\":\"success\",\"type\":\"bool\"}],\"stateMutability\":\"nonpayable\",\"type\":\"function\"},{\"inputs\":[{\"internalType\":\"address[]\",\"name\":\"addrs\",\"type\":\"address[]\"}],\"name\":\"addAddressesToBlacklist\",\"outputs\":[{\"internalType\":\"bool\",\"name\":\"success\",\"type\":\"bool\"}],\"stateMutability\":\"nonpayable\",\"type\":\"function\"},{\"inputs\":[{\"internalType\":\"address\",\"name\":\"owner\",\"type\":\"address\"},{\"internalType\":\"address\",\"name\":\"spender\",\"type\":\"address\"}],\"name\":\"allowance\",\"outputs\":[{\"internalType\":\"uint256\",\"name\":\"\",\"type\":\"uint256\"}],\"stateMutability\":\"view\",\"type\":\"function\"},{\"inputs\":[{\"internalType\":\"address\",\"name\":\"_spender\",\"type\":\"address\"},{\"internalType\":\"uint256\",\"name\":\"_value\",\"type\":\"uint256\"}],\"name\":\"approve\",\"outputs\":[{\"internalType\":\"bool\",\"name\":\"\",\"type\":\"bool\"}],\"stateMutability\":\"nonpayable\",\"type\":\"function\"},{\"inputs\":[{\"internalType\":\"address\",\"name\":\"account\",\"type\":\"address\"}],\"name\":\"balanceOf\",\"outputs\":[{\"internalType\":\"uint256\",\"name\":\"\",\"type\":\"uint256\"}],\"stateMutability\":\"view\",\"type\":\"function\"},{\"inputs\":[{\"internalType\":\"uint256\",\"name\":\"\",\"type\":\"uint256\"}],\"name\":\"blacklistAddresses\",\"outputs\":[{\"internalType\":\"address\",\"name\":\"\",\"type\":\"address\"}],\"stateMutability\":\"view\",\"type\":\"function\"},{\"inputs\":[{\"internalType\":\"uint256\",\"name\":\"amount\",\"type\":\"uint256\"}],\"name\":\"burn\",\"outputs\":[],\"stateMutability\":\"nonpayable\",\"type\":\"function\"},{\"inputs\":[],\"name\":\"decimals\",\"outputs\":[{\"internalType\":\"uint8\",\"name\":\"\",\"type\":\"uint8\"}],\"stateMutability\":\"view\",\"type\":\"function\"},{\"inputs\":[{\"internalType\":\"address\",\"name\":\"spender\",\"type\":\"address\"},{\"internalType\":\"uint256\",\"name\":\"subtractedValue\",\"type\":\"uint256\"}],\"name\":\"decreaseAllowance\",\"outputs\":[{\"internalType\":\"bool\",\"name\":\"\",\"type\":\"bool\"}],\"stateMutability\":\"nonpayable\",\"type\":\"function\"},{\"inputs\":[],\"name\":\"getBlacklist\",\"outputs\":[{\"internalType\":\"address[]\",\"name\":\"\",\"type\":\"address[]\"}],\"stateMutability\":\"view\",\"type\":\"function\"},{\"inputs\":[],\"name\":\"getOwner\",\"outputs\":[{\"internalType\":\"address\",\"name\":\"\",\"type\":\"address\"}],\"stateMutability\":\"view\",\"type\":\"function\"},{\"inputs\":[{\"internalType\":\"address\",\"name\":\"spender\",\"type\":\"address\"},{\"internalType\":\"uint256\",\"name\":\"addedValue\",\"type\":\"uint256\"}],\"name\":\"increaseAllowance\",\"outputs\":[{\"internalType\":\"bool\",\"name\":\"\",\"type\":\"bool\"}],\"stateMutability\":\"nonpayable\",\"type\":\"function\"},{\"inputs\":[],\"name\":\"mint\",\"outputs\":[],\"stateMutability\":\"nonpayable\",\"type\":\"function\"},{\"inputs\":[{\"internalType\":\"uint256\",\"name\":\"amount\",\"type\":\"uint256\"}],\"name\":\"mintManager\",\"outputs\":[],\"stateMutability\":\"nonpayable\",\"type\":\"function\"},{\"inputs\":[],\"name\":\"mintingDates\",\"outputs\":[{\"internalType\":\"uint256[]\",\"name\":\"\",\"type\":\"uint256[]\"}],\"stateMutability\":\"view\",\"type\":\"function\"},{\"inputs\":[],\"name\":\"name\",\"outputs\":[{\"internalType\":\"string\",\"name\":\"\",\"type\":\"string\"}],\"stateMutability\":\"view\",\"type\":\"function\"},{\"inputs\":[],\"name\":\"owner\",\"outputs\":[{\"internalType\":\"address\",\"name\":\"\",\"type\":\"address\"}],\"stateMutability\":\"view\",\"type\":\"function\"},{\"inputs\":[],\"name\":\"pauseContract\",\"outputs\":[{\"internalType\":\"bool\",\"name\":\"\",\"type\":\"bool\"}],\"stateMutability\":\"nonpayable\",\"type\":\"function\"},{\"inputs\":[],\"name\":\"paused\",\"outputs\":[{\"internalType\":\"bool\",\"name\":\"\",\"type\":\"bool\"}],\"stateMutability\":\"view\",\"type\":\"function\"},{\"inputs\":[],\"name\":\"remainingMintingAmount\",\"outputs\":[{\"internalType\":\"uint256\",\"name\":\"\",\"type\":\"uint256\"}],\"stateMutability\":\"view\",\"type\":\"function\"},{\"inputs\":[{\"internalType\":\"address\",\"name\":\"addr\",\"type\":\"address\"}],\"name\":\"removeAddressFromBlacklist\",\"outputs\":[{\"internalType\":\"bool\",\"name\":\"success\",\"type\":\"bool\"}],\"stateMutability\":\"nonpayable\",\"type\":\"function\"},{\"inputs\":[{\"internalType\":\"address[]\",\"name\":\"addrs\",\"type\":\"address[]\"}],\"name\":\"removeAddressesFromBlacklist\",\"outputs\":[{\"internalType\":\"bool\",\"name\":\"success\",\"type\":\"bool\"}],\"stateMutability\":\"nonpayable\",\"type\":\"function\"},{\"inputs\":[],\"name\":\"renounceOwnership\",\"outputs\":[],\"stateMutability\":\"nonpayable\",\"type\":\"function\"},{\"inputs\":[],\"name\":\"symbol\",\"outputs\":[{\"internalType\":\"string\",\"name\":\"\",\"type\":\"string\"}],\"stateMutability\":\"view\",\"type\":\"function\"},{\"inputs\":[],\"name\":\"totalBurned\",\"outputs\":[{\"internalType\":\"uint256\",\"name\":\"\",\"type\":\"uint256\"}],\"stateMutability\":\"view\",\"type\":\"function\"},{\"inputs\":[],\"name\":\"totalSupply\",\"outputs\":[{\"internalType\":\"uint256\",\"name\":\"\",\"type\":\"uint256\"}],\"stateMutability\":\"view\",\"type\":\"function\"},{\"inputs\":[{\"internalType\":\"address\",\"name\":\"_to\",\"type\":\"address\"},{\"internalType\":\"uint256\",\"name\":\"_value\",\"type\":\"uint256\"}],\"name\":\"transfer\",\"outputs\":[{\"internalType\":\"bool\",\"name\":\"\",\"type\":\"bool\"}],\"stateMutability\":\"nonpayable\",\"type\":\"function\"},{\"inputs\":[{\"internalType\":\"address\",\"name\":\"_from\",\"type\":\"address\"},{\"internalType\":\"address\",\"name\":\"_to\",\"type\":\"address\"},{\"internalType\":\"uint256\",\"name\":\"_value\",\"type\":\"uint256\"}],\"name\":\"transferFrom\",\"outputs\":[{\"internalType\":\"bool\",\"name\":\"\",\"type\":\"bool\"}],\"stateMutability\":\"nonpayable\",\"type\":\"function\"},{\"inputs\":[{\"internalType\":\"address\",\"name\":\"newOwner\",\"type\":\"address\"}],\"name\":\"transferOwnership\",\"outputs\":[],\"stateMutability\":\"nonpayable\",\"type\":\"function\"},{\"inputs\":[],\"name\":\"unpauseContract\",\"outputs\":[{\"internalType\":\"bool\",\"name\":\"\",\"type\":\"bool\"}],\"stateMutability\":\"nonpayable\",\"type\":\"function\"}]",
}

// SpinABI is the input ABI used to generate the binding from.
// Deprecated: Use SpinMetaData.ABI instead.
var SpinABI = SpinMetaData.ABI

// Spin is an auto generated Go binding around an Ethereum contract.
type Spin struct {
	SpinCaller     // Read-only binding to the contract
	SpinTransactor // Write-only binding to the contract
	SpinFilterer   // Log filterer for contract events
}

// SpinCaller is an auto generated read-only Go binding around an Ethereum contract.
type SpinCaller struct {
	contract *bind.BoundContract // Generic contract wrapper for the low level calls
}

// SpinTransactor is an auto generated write-only Go binding around an Ethereum contract.
type SpinTransactor struct {
	contract *bind.BoundContract // Generic contract wrapper for the low level calls
}

// SpinFilterer is an auto generated log filtering Go binding around an Ethereum contract events.
type SpinFilterer struct {
	contract *bind.BoundContract // Generic contract wrapper for the low level calls
}

// SpinSession is an auto generated Go binding around an Ethereum contract,
// with pre-set call and transact options.
type SpinSession struct {
	Contract     *Spin             // Generic contract binding to set the session for
	CallOpts     bind.CallOpts     // Call options to use throughout this session
	TransactOpts bind.TransactOpts // Transaction auth options to use throughout this session
}

// SpinCallerSession is an auto generated read-only Go binding around an Ethereum contract,
// with pre-set call options.
type SpinCallerSession struct {
	Contract *SpinCaller   // Generic contract caller binding to set the session for
	CallOpts bind.CallOpts // Call options to use throughout this session
}

// SpinTransactorSession is an auto generated write-only Go binding around an Ethereum contract,
// with pre-set transact options.
type SpinTransactorSession struct {
	Contract     *SpinTransactor   // Generic contract transactor binding to set the session for
	TransactOpts bind.TransactOpts // Transaction auth options to use throughout this session
}

// SpinRaw is an auto generated low-level Go binding around an Ethereum contract.
type SpinRaw struct {
	Contract *Spin // Generic contract binding to access the raw methods on
}

// SpinCallerRaw is an auto generated low-level read-only Go binding around an Ethereum contract.
type SpinCallerRaw struct {
	Contract *SpinCaller // Generic read-only contract binding to access the raw methods on
}

// SpinTransactorRaw is an auto generated low-level write-only Go binding around an Ethereum contract.
type SpinTransactorRaw struct {
	Contract *SpinTransactor // Generic write-only contract binding to access the raw methods on
}

// NewSpin creates a new instance of Spin, bound to a specific deployed contract.
func NewSpin(address common.Address, backend bind.ContractBackend) (*Spin, error) {
	contract, err := bindSpin(address, backend, backend, backend)
	if err != nil {
		return nil, err
	}
	return &Spin{SpinCaller: SpinCaller{contract: contract}, SpinTransactor: SpinTransactor{contract: contract}, SpinFilterer: SpinFilterer{contract: contract}}, nil
}

// NewSpinCaller creates a new read-only instance of Spin, bound to a specific deployed contract.
func NewSpinCaller(address common.Address, caller bind.ContractCaller) (*SpinCaller, error) {
	contract, err := bindSpin(address, caller, nil, nil)
	if err != nil {
		return nil, err
	}
	return &SpinCaller{contract: contract}, nil
}

// NewSpinTransactor creates a new write-only instance of Spin, bound to a specific deployed contract.
func NewSpinTransactor(address common.Address, transactor bind.ContractTransactor) (*SpinTransactor, error) {
	contract, err := bindSpin(address, nil, transactor, nil)
	if err != nil {
		return nil, err
	}
	return &SpinTransactor{contract: contract}, nil
}

// NewSpinFilterer creates a new log filterer instance of Spin, bound to a specific deployed contract.
func NewSpinFilterer(address common.Address, filterer bind.ContractFilterer) (*SpinFilterer, error) {
	contract, err := bindSpin(address, nil, nil, filterer)
	if err != nil {
		return nil, err
	}
	return &SpinFilterer{contract: contract}, nil
}

// bindSpin binds a generic wrapper to an already deployed contract.
func bindSpin(address common.Address, caller bind.ContractCaller, transactor bind.ContractTransactor, filterer bind.ContractFilterer) (*bind.BoundContract, error) {
	parsed, err := SpinMetaData.GetAbi()
	if err != nil {
		return nil, err
	}
	return bind.NewBoundContract(address, *parsed, caller, transactor, filterer), nil
}

// Call invokes the (constant) contract method with params as input values and
// sets the output to result. The result type might be a single field for simple
// returns, a slice of interfaces for anonymous returns and a struct for named
// returns.
func (_Spin *SpinRaw) Call(opts *bind.CallOpts, result *[]interface{}, method string, params ...interface{}) error {
	return _Spin.Contract.SpinCaller.contract.Call(opts, result, method, params...)
}

// Transfer initiates a plain transaction to move funds to the contract, calling
// its default method if one is available.
func (_Spin *SpinRaw) Transfer(opts *bind.TransactOpts) (*types.Transaction, error) {
	return _Spin.Contract.SpinTransactor.contract.Transfer(opts)
}

// Transact invokes the (paid) contract method with params as input values.
func (_Spin *SpinRaw) Transact(opts *bind.TransactOpts, method string, params ...interface{}) (*types.Transaction, error) {
	return _Spin.Contract.SpinTransactor.contract.Transact(opts, method, params...)
}

// Call invokes the (constant) contract method with params as input values and
// sets the output to result. The result type might be a single field for simple
// returns, a slice of interfaces for anonymous returns and a struct for named
// returns.
func (_Spin *SpinCallerRaw) Call(opts *bind.CallOpts, result *[]interface{}, method string, params ...interface{}) error {
	return _Spin.Contract.contract.Call(opts, result, method, params...)
}

// Transfer initiates a plain transaction to move funds to the contract, calling
// its default method if one is available.
func (_Spin *SpinTransactorRaw) Transfer(opts *bind.TransactOpts) (*types.Transaction, error) {
	return _Spin.Contract.contract.Transfer(opts)
}

// Transact invokes the (paid) contract method with params as input values.
func (_Spin *SpinTransactorRaw) Transact(opts *bind.TransactOpts, method string, params ...interface{}) (*types.Transaction, error) {
	return _Spin.Contract.contract.Transact(opts, method, params...)
}

// CirculatingSupply is a free data retrieval call binding the contract method 0x92d60433.
//
// Solidity: function CirculatingSupply() view returns(uint256)
func (_Spin *SpinCaller) CirculatingSupply(opts *bind.CallOpts) (*big.Int, error) {
	var out []interface{}
	err := _Spin.contract.Call(opts, &out, "CirculatingSupply")

	if err != nil {
		return *new(*big.Int), err
	}

	out0 := *abi.ConvertType(out[0], new(*big.Int)).(**big.Int)

	return out0, err

}

// CirculatingSupply is a free data retrieval call binding the contract method 0x92d60433.
//
// Solidity: function CirculatingSupply() view returns(uint256)
func (_Spin *SpinSession) CirculatingSupply() (*big.Int, error) {
	return _Spin.Contract.CirculatingSupply(&_Spin.CallOpts)
}

// CirculatingSupply is a free data retrieval call binding the contract method 0x92d60433.
//
// Solidity: function CirculatingSupply() view returns(uint256)
func (_Spin *SpinCallerSession) CirculatingSupply() (*big.Int, error) {
	return _Spin.Contract.CirculatingSupply(&_Spin.CallOpts)
}

// Allowance is a free data retrieval call binding the contract method 0xdd62ed3e.
//
// Solidity: function allowance(address owner, address spender) view returns(uint256)
func (_Spin *SpinCaller) Allowance(opts *bind.CallOpts, owner common.Address, spender common.Address) (*big.Int, error) {
	var out []interface{}
	err := _Spin.contract.Call(opts, &out, "allowance", owner, spender)

	if err != nil {
		return *new(*big.Int), err
	}

	out0 := *abi.ConvertType(out[0], new(*big.Int)).(**big.Int)

	return out0, err

}

// Allowance is a free data retrieval call binding the contract method 0xdd62ed3e.
//
// Solidity: function allowance(address owner, address spender) view returns(uint256)
func (_Spin *SpinSession) Allowance(owner common.Address, spender common.Address) (*big.Int, error) {
	return _Spin.Contract.Allowance(&_Spin.CallOpts, owner, spender)
}

// Allowance is a free data retrieval call binding the contract method 0xdd62ed3e.
//
// Solidity: function allowance(address owner, address spender) view returns(uint256)
func (_Spin *SpinCallerSession) Allowance(owner common.Address, spender common.Address) (*big.Int, error) {
	return _Spin.Contract.Allowance(&_Spin.CallOpts, owner, spender)
}

// BalanceOf is a free data retrieval call binding the contract method 0x70a08231.
//
// Solidity: function balanceOf(address account) view returns(uint256)
func (_Spin *SpinCaller) BalanceOf(opts *bind.CallOpts, account common.Address) (*big.Int, error) {
	var out []interface{}
	err := _Spin.contract.Call(opts, &out, "balanceOf", account)

	if err != nil {
		return *new(*big.Int), err
	}

	out0 := *abi.ConvertType(out[0], new(*big.Int)).(**big.Int)

	return out0, err

}

// BalanceOf is a free data retrieval call binding the contract method 0x70a08231.
//
// Solidity: function balanceOf(address account) view returns(uint256)
func (_Spin *SpinSession) BalanceOf(account common.Address) (*big.Int, error) {
	return _Spin.Contract.BalanceOf(&_Spin.CallOpts, account)
}

// BalanceOf is a free data retrieval call binding the contract method 0x70a08231.
//
// Solidity: function balanceOf(address account) view returns(uint256)
func (_Spin *SpinCallerSession) BalanceOf(account common.Address) (*big.Int, error) {
	return _Spin.Contract.BalanceOf(&_Spin.CallOpts, account)
}

// BlacklistAddresses is a free data retrieval call binding the contract method 0x1e55a376.
//
// Solidity: function blacklistAddresses(uint256 ) view returns(address)
func (_Spin *SpinCaller) BlacklistAddresses(opts *bind.CallOpts, arg0 *big.Int) (common.Address, error) {
	var out []interface{}
	err := _Spin.contract.Call(opts, &out, "blacklistAddresses", arg0)

	if err != nil {
		return *new(common.Address), err
	}

	out0 := *abi.ConvertType(out[0], new(common.Address)).(*common.Address)

	return out0, err

}

// BlacklistAddresses is a free data retrieval call binding the contract method 0x1e55a376.
//
// Solidity: function blacklistAddresses(uint256 ) view returns(address)
func (_Spin *SpinSession) BlacklistAddresses(arg0 *big.Int) (common.Address, error) {
	return _Spin.Contract.BlacklistAddresses(&_Spin.CallOpts, arg0)
}

// BlacklistAddresses is a free data retrieval call binding the contract method 0x1e55a376.
//
// Solidity: function blacklistAddresses(uint256 ) view returns(address)
func (_Spin *SpinCallerSession) BlacklistAddresses(arg0 *big.Int) (common.Address, error) {
	return _Spin.Contract.BlacklistAddresses(&_Spin.CallOpts, arg0)
}

// Decimals is a free data retrieval call binding the contract method 0x313ce567.
//
// Solidity: function decimals() view returns(uint8)
func (_Spin *SpinCaller) Decimals(opts *bind.CallOpts) (uint8, error) {
	var out []interface{}
	err := _Spin.contract.Call(opts, &out, "decimals")

	if err != nil {
		return *new(uint8), err
	}

	out0 := *abi.ConvertType(out[0], new(uint8)).(*uint8)

	return out0, err

}

// Decimals is a free data retrieval call binding the contract method 0x313ce567.
//
// Solidity: function decimals() view returns(uint8)
func (_Spin *SpinSession) Decimals() (uint8, error) {
	return _Spin.Contract.Decimals(&_Spin.CallOpts)
}

// Decimals is a free data retrieval call binding the contract method 0x313ce567.
//
// Solidity: function decimals() view returns(uint8)
func (_Spin *SpinCallerSession) Decimals() (uint8, error) {
	return _Spin.Contract.Decimals(&_Spin.CallOpts)
}

// GetBlacklist is a free data retrieval call binding the contract method 0x338d6c30.
//
// Solidity: function getBlacklist() view returns(address[])
func (_Spin *SpinCaller) GetBlacklist(opts *bind.CallOpts) ([]common.Address, error) {
	var out []interface{}
	err := _Spin.contract.Call(opts, &out, "getBlacklist")

	if err != nil {
		return *new([]common.Address), err
	}

	out0 := *abi.ConvertType(out[0], new([]common.Address)).(*[]common.Address)

	return out0, err

}

// GetBlacklist is a free data retrieval call binding the contract method 0x338d6c30.
//
// Solidity: function getBlacklist() view returns(address[])
func (_Spin *SpinSession) GetBlacklist() ([]common.Address, error) {
	return _Spin.Contract.GetBlacklist(&_Spin.CallOpts)
}

// GetBlacklist is a free data retrieval call binding the contract method 0x338d6c30.
//
// Solidity: function getBlacklist() view returns(address[])
func (_Spin *SpinCallerSession) GetBlacklist() ([]common.Address, error) {
	return _Spin.Contract.GetBlacklist(&_Spin.CallOpts)
}

// GetOwner is a free data retrieval call binding the contract method 0x893d20e8.
//
// Solidity: function getOwner() view returns(address)
func (_Spin *SpinCaller) GetOwner(opts *bind.CallOpts) (common.Address, error) {
	var out []interface{}
	err := _Spin.contract.Call(opts, &out, "getOwner")

	if err != nil {
		return *new(common.Address), err
	}

	out0 := *abi.ConvertType(out[0], new(common.Address)).(*common.Address)

	return out0, err

}

// GetOwner is a free data retrieval call binding the contract method 0x893d20e8.
//
// Solidity: function getOwner() view returns(address)
func (_Spin *SpinSession) GetOwner() (common.Address, error) {
	return _Spin.Contract.GetOwner(&_Spin.CallOpts)
}

// GetOwner is a free data retrieval call binding the contract method 0x893d20e8.
//
// Solidity: function getOwner() view returns(address)
func (_Spin *SpinCallerSession) GetOwner() (common.Address, error) {
	return _Spin.Contract.GetOwner(&_Spin.CallOpts)
}

// MintingDates is a free data retrieval call binding the contract method 0x682d2bb6.
//
// Solidity: function mintingDates() view returns(uint256[])
func (_Spin *SpinCaller) MintingDates(opts *bind.CallOpts) ([]*big.Int, error) {
	var out []interface{}
	err := _Spin.contract.Call(opts, &out, "mintingDates")

	if err != nil {
		return *new([]*big.Int), err
	}

	out0 := *abi.ConvertType(out[0], new([]*big.Int)).(*[]*big.Int)

	return out0, err

}

// MintingDates is a free data retrieval call binding the contract method 0x682d2bb6.
//
// Solidity: function mintingDates() view returns(uint256[])
func (_Spin *SpinSession) MintingDates() ([]*big.Int, error) {
	return _Spin.Contract.MintingDates(&_Spin.CallOpts)
}

// MintingDates is a free data retrieval call binding the contract method 0x682d2bb6.
//
// Solidity: function mintingDates() view returns(uint256[])
func (_Spin *SpinCallerSession) MintingDates() ([]*big.Int, error) {
	return _Spin.Contract.MintingDates(&_Spin.CallOpts)
}

// Name is a free data retrieval call binding the contract method 0x06fdde03.
//
// Solidity: function name() view returns(string)
func (_Spin *SpinCaller) Name(opts *bind.CallOpts) (string, error) {
	var out []interface{}
	err := _Spin.contract.Call(opts, &out, "name")

	if err != nil {
		return *new(string), err
	}

	out0 := *abi.ConvertType(out[0], new(string)).(*string)

	return out0, err

}

// Name is a free data retrieval call binding the contract method 0x06fdde03.
//
// Solidity: function name() view returns(string)
func (_Spin *SpinSession) Name() (string, error) {
	return _Spin.Contract.Name(&_Spin.CallOpts)
}

// Name is a free data retrieval call binding the contract method 0x06fdde03.
//
// Solidity: function name() view returns(string)
func (_Spin *SpinCallerSession) Name() (string, error) {
	return _Spin.Contract.Name(&_Spin.CallOpts)
}

// Owner is a free data retrieval call binding the contract method 0x8da5cb5b.
//
// Solidity: function owner() view returns(address)
func (_Spin *SpinCaller) Owner(opts *bind.CallOpts) (common.Address, error) {
	var out []interface{}
	err := _Spin.contract.Call(opts, &out, "owner")

	if err != nil {
		return *new(common.Address), err
	}

	out0 := *abi.ConvertType(out[0], new(common.Address)).(*common.Address)

	return out0, err

}

// Owner is a free data retrieval call binding the contract method 0x8da5cb5b.
//
// Solidity: function owner() view returns(address)
func (_Spin *SpinSession) Owner() (common.Address, error) {
	return _Spin.Contract.Owner(&_Spin.CallOpts)
}

// Owner is a free data retrieval call binding the contract method 0x8da5cb5b.
//
// Solidity: function owner() view returns(address)
func (_Spin *SpinCallerSession) Owner() (common.Address, error) {
	return _Spin.Contract.Owner(&_Spin.CallOpts)
}

// Paused is a free data retrieval call binding the contract method 0x5c975abb.
//
// Solidity: function paused() view returns(bool)
func (_Spin *SpinCaller) Paused(opts *bind.CallOpts) (bool, error) {
	var out []interface{}
	err := _Spin.contract.Call(opts, &out, "paused")

	if err != nil {
		return *new(bool), err
	}

	out0 := *abi.ConvertType(out[0], new(bool)).(*bool)

	return out0, err

}

// Paused is a free data retrieval call binding the contract method 0x5c975abb.
//
// Solidity: function paused() view returns(bool)
func (_Spin *SpinSession) Paused() (bool, error) {
	return _Spin.Contract.Paused(&_Spin.CallOpts)
}

// Paused is a free data retrieval call binding the contract method 0x5c975abb.
//
// Solidity: function paused() view returns(bool)
func (_Spin *SpinCallerSession) Paused() (bool, error) {
	return _Spin.Contract.Paused(&_Spin.CallOpts)
}

// RemainingMintingAmount is a free data retrieval call binding the contract method 0x7f05afff.
//
// Solidity: function remainingMintingAmount() view returns(uint256)
func (_Spin *SpinCaller) RemainingMintingAmount(opts *bind.CallOpts) (*big.Int, error) {
	var out []interface{}
	err := _Spin.contract.Call(opts, &out, "remainingMintingAmount")

	if err != nil {
		return *new(*big.Int), err
	}

	out0 := *abi.ConvertType(out[0], new(*big.Int)).(**big.Int)

	return out0, err

}

// RemainingMintingAmount is a free data retrieval call binding the contract method 0x7f05afff.
//
// Solidity: function remainingMintingAmount() view returns(uint256)
func (_Spin *SpinSession) RemainingMintingAmount() (*big.Int, error) {
	return _Spin.Contract.RemainingMintingAmount(&_Spin.CallOpts)
}

// RemainingMintingAmount is a free data retrieval call binding the contract method 0x7f05afff.
//
// Solidity: function remainingMintingAmount() view returns(uint256)
func (_Spin *SpinCallerSession) RemainingMintingAmount() (*big.Int, error) {
	return _Spin.Contract.RemainingMintingAmount(&_Spin.CallOpts)
}

// Symbol is a free data retrieval call binding the contract method 0x95d89b41.
//
// Solidity: function symbol() view returns(string)
func (_Spin *SpinCaller) Symbol(opts *bind.CallOpts) (string, error) {
	var out []interface{}
	err := _Spin.contract.Call(opts, &out, "symbol")

	if err != nil {
		return *new(string), err
	}

	out0 := *abi.ConvertType(out[0], new(string)).(*string)

	return out0, err

}

// Symbol is a free data retrieval call binding the contract method 0x95d89b41.
//
// Solidity: function symbol() view returns(string)
func (_Spin *SpinSession) Symbol() (string, error) {
	return _Spin.Contract.Symbol(&_Spin.CallOpts)
}

// Symbol is a free data retrieval call binding the contract method 0x95d89b41.
//
// Solidity: function symbol() view returns(string)
func (_Spin *SpinCallerSession) Symbol() (string, error) {
	return _Spin.Contract.Symbol(&_Spin.CallOpts)
}

// TotalBurned is a free data retrieval call binding the contract method 0xd89135cd.
//
// Solidity: function totalBurned() view returns(uint256)
func (_Spin *SpinCaller) TotalBurned(opts *bind.CallOpts) (*big.Int, error) {
	var out []interface{}
	err := _Spin.contract.Call(opts, &out, "totalBurned")

	if err != nil {
		return *new(*big.Int), err
	}

	out0 := *abi.ConvertType(out[0], new(*big.Int)).(**big.Int)

	return out0, err

}

// TotalBurned is a free data retrieval call binding the contract method 0xd89135cd.
//
// Solidity: function totalBurned() view returns(uint256)
func (_Spin *SpinSession) TotalBurned() (*big.Int, error) {
	return _Spin.Contract.TotalBurned(&_Spin.CallOpts)
}

// TotalBurned is a free data retrieval call binding the contract method 0xd89135cd.
//
// Solidity: function totalBurned() view returns(uint256)
func (_Spin *SpinCallerSession) TotalBurned() (*big.Int, error) {
	return _Spin.Contract.TotalBurned(&_Spin.CallOpts)
}

// TotalSupply is a free data retrieval call binding the contract method 0x18160ddd.
//
// Solidity: function totalSupply() view returns(uint256)
func (_Spin *SpinCaller) TotalSupply(opts *bind.CallOpts) (*big.Int, error) {
	var out []interface{}
	err := _Spin.contract.Call(opts, &out, "totalSupply")

	if err != nil {
		return *new(*big.Int), err
	}

	out0 := *abi.ConvertType(out[0], new(*big.Int)).(**big.Int)

	return out0, err

}

// TotalSupply is a free data retrieval call binding the contract method 0x18160ddd.
//
// Solidity: function totalSupply() view returns(uint256)
func (_Spin *SpinSession) TotalSupply() (*big.Int, error) {
	return _Spin.Contract.TotalSupply(&_Spin.CallOpts)
}

// TotalSupply is a free data retrieval call binding the contract method 0x18160ddd.
//
// Solidity: function totalSupply() view returns(uint256)
func (_Spin *SpinCallerSession) TotalSupply() (*big.Int, error) {
	return _Spin.Contract.TotalSupply(&_Spin.CallOpts)
}

// AddAddressToBlacklist is a paid mutator transaction binding the contract method 0xf2c816ae.
//
// Solidity: function addAddressToBlacklist(address addr) returns(bool success)
func (_Spin *SpinTransactor) AddAddressToBlacklist(opts *bind.TransactOpts, addr common.Address) (*types.Transaction, error) {
	return _Spin.contract.Transact(opts, "addAddressToBlacklist", addr)
}

// AddAddressToBlacklist is a paid mutator transaction binding the contract method 0xf2c816ae.
//
// Solidity: function addAddressToBlacklist(address addr) returns(bool success)
func (_Spin *SpinSession) AddAddressToBlacklist(addr common.Address) (*types.Transaction, error) {
	return _Spin.Contract.AddAddressToBlacklist(&_Spin.TransactOpts, addr)
}

// AddAddressToBlacklist is a paid mutator transaction binding the contract method 0xf2c816ae.
//
// Solidity: function addAddressToBlacklist(address addr) returns(bool success)
func (_Spin *SpinTransactorSession) AddAddressToBlacklist(addr common.Address) (*types.Transaction, error) {
	return _Spin.Contract.AddAddressToBlacklist(&_Spin.TransactOpts, addr)
}

// AddAddressesToBlacklist is a paid mutator transaction binding the contract method 0xca73419e.
//
// Solidity: function addAddressesToBlacklist(address[] addrs) returns(bool success)
func (_Spin *SpinTransactor) AddAddressesToBlacklist(opts *bind.TransactOpts, addrs []common.Address) (*types.Transaction, error) {
	return _Spin.contract.Transact(opts, "addAddressesToBlacklist", addrs)
}

// AddAddressesToBlacklist is a paid mutator transaction binding the contract method 0xca73419e.
//
// Solidity: function addAddressesToBlacklist(address[] addrs) returns(bool success)
func (_Spin *SpinSession) AddAddressesToBlacklist(addrs []common.Address) (*types.Transaction, error) {
	return _Spin.Contract.AddAddressesToBlacklist(&_Spin.TransactOpts, addrs)
}

// AddAddressesToBlacklist is a paid mutator transaction binding the contract method 0xca73419e.
//
// Solidity: function addAddressesToBlacklist(address[] addrs) returns(bool success)
func (_Spin *SpinTransactorSession) AddAddressesToBlacklist(addrs []common.Address) (*types.Transaction, error) {
	return _Spin.Contract.AddAddressesToBlacklist(&_Spin.TransactOpts, addrs)
}

// Approve is a paid mutator transaction binding the contract method 0x095ea7b3.
//
// Solidity: function approve(address _spender, uint256 _value) returns(bool)
func (_Spin *SpinTransactor) Approve(opts *bind.TransactOpts, _spender common.Address, _value *big.Int) (*types.Transaction, error) {
	return _Spin.contract.Transact(opts, "approve", _spender, _value)
}

// Approve is a paid mutator transaction binding the contract method 0x095ea7b3.
//
// Solidity: function approve(address _spender, uint256 _value) returns(bool)
func (_Spin *SpinSession) Approve(_spender common.Address, _value *big.Int) (*types.Transaction, error) {
	return _Spin.Contract.Approve(&_Spin.TransactOpts, _spender, _value)
}

// Approve is a paid mutator transaction binding the contract method 0x095ea7b3.
//
// Solidity: function approve(address _spender, uint256 _value) returns(bool)
func (_Spin *SpinTransactorSession) Approve(_spender common.Address, _value *big.Int) (*types.Transaction, error) {
	return _Spin.Contract.Approve(&_Spin.TransactOpts, _spender, _value)
}

// Burn is a paid mutator transaction binding the contract method 0x42966c68.
//
// Solidity: function burn(uint256 amount) returns()
func (_Spin *SpinTransactor) Burn(opts *bind.TransactOpts, amount *big.Int) (*types.Transaction, error) {
	return _Spin.contract.Transact(opts, "burn", amount)
}

// Burn is a paid mutator transaction binding the contract method 0x42966c68.
//
// Solidity: function burn(uint256 amount) returns()
func (_Spin *SpinSession) Burn(amount *big.Int) (*types.Transaction, error) {
	return _Spin.Contract.Burn(&_Spin.TransactOpts, amount)
}

// Burn is a paid mutator transaction binding the contract method 0x42966c68.
//
// Solidity: function burn(uint256 amount) returns()
func (_Spin *SpinTransactorSession) Burn(amount *big.Int) (*types.Transaction, error) {
	return _Spin.Contract.Burn(&_Spin.TransactOpts, amount)
}

// DecreaseAllowance is a paid mutator transaction binding the contract method 0xa457c2d7.
//
// Solidity: function decreaseAllowance(address spender, uint256 subtractedValue) returns(bool)
func (_Spin *SpinTransactor) DecreaseAllowance(opts *bind.TransactOpts, spender common.Address, subtractedValue *big.Int) (*types.Transaction, error) {
	return _Spin.contract.Transact(opts, "decreaseAllowance", spender, subtractedValue)
}

// DecreaseAllowance is a paid mutator transaction binding the contract method 0xa457c2d7.
//
// Solidity: function decreaseAllowance(address spender, uint256 subtractedValue) returns(bool)
func (_Spin *SpinSession) DecreaseAllowance(spender common.Address, subtractedValue *big.Int) (*types.Transaction, error) {
	return _Spin.Contract.DecreaseAllowance(&_Spin.TransactOpts, spender, subtractedValue)
}

// DecreaseAllowance is a paid mutator transaction binding the contract method 0xa457c2d7.
//
// Solidity: function decreaseAllowance(address spender, uint256 subtractedValue) returns(bool)
func (_Spin *SpinTransactorSession) DecreaseAllowance(spender common.Address, subtractedValue *big.Int) (*types.Transaction, error) {
	return _Spin.Contract.DecreaseAllowance(&_Spin.TransactOpts, spender, subtractedValue)
}

// IncreaseAllowance is a paid mutator transaction binding the contract method 0x39509351.
//
// Solidity: function increaseAllowance(address spender, uint256 addedValue) returns(bool)
func (_Spin *SpinTransactor) IncreaseAllowance(opts *bind.TransactOpts, spender common.Address, addedValue *big.Int) (*types.Transaction, error) {
	return _Spin.contract.Transact(opts, "increaseAllowance", spender, addedValue)
}

// IncreaseAllowance is a paid mutator transaction binding the contract method 0x39509351.
//
// Solidity: function increaseAllowance(address spender, uint256 addedValue) returns(bool)
func (_Spin *SpinSession) IncreaseAllowance(spender common.Address, addedValue *big.Int) (*types.Transaction, error) {
	return _Spin.Contract.IncreaseAllowance(&_Spin.TransactOpts, spender, addedValue)
}

// IncreaseAllowance is a paid mutator transaction binding the contract method 0x39509351.
//
// Solidity: function increaseAllowance(address spender, uint256 addedValue) returns(bool)
func (_Spin *SpinTransactorSession) IncreaseAllowance(spender common.Address, addedValue *big.Int) (*types.Transaction, error) {
	return _Spin.Contract.IncreaseAllowance(&_Spin.TransactOpts, spender, addedValue)
}

// Mint is a paid mutator transaction binding the contract method 0x1249c58b.
//
// Solidity: function mint() returns()
func (_Spin *SpinTransactor) Mint(opts *bind.TransactOpts) (*types.Transaction, error) {
	return _Spin.contract.Transact(opts, "mint")
}

// Mint is a paid mutator transaction binding the contract method 0x1249c58b.
//
// Solidity: function mint() returns()
func (_Spin *SpinSession) Mint() (*types.Transaction, error) {
	return _Spin.Contract.Mint(&_Spin.TransactOpts)
}

// Mint is a paid mutator transaction binding the contract method 0x1249c58b.
//
// Solidity: function mint() returns()
func (_Spin *SpinTransactorSession) Mint() (*types.Transaction, error) {
	return _Spin.Contract.Mint(&_Spin.TransactOpts)
}

// MintManager is a paid mutator transaction binding the contract method 0xa5f035a4.
//
// Solidity: function mintManager(uint256 amount) returns()
func (_Spin *SpinTransactor) MintManager(opts *bind.TransactOpts, amount *big.Int) (*types.Transaction, error) {
	return _Spin.contract.Transact(opts, "mintManager", amount)
}

// MintManager is a paid mutator transaction binding the contract method 0xa5f035a4.
//
// Solidity: function mintManager(uint256 amount) returns()
func (_Spin *SpinSession) MintManager(amount *big.Int) (*types.Transaction, error) {
	return _Spin.Contract.MintManager(&_Spin.TransactOpts, amount)
}

// MintManager is a paid mutator transaction binding the contract method 0xa5f035a4.
//
// Solidity: function mintManager(uint256 amount) returns()
func (_Spin *SpinTransactorSession) MintManager(amount *big.Int) (*types.Transaction, error) {
	return _Spin.Contract.MintManager(&_Spin.TransactOpts, amount)
}

// PauseContract is a paid mutator transaction binding the contract method 0x439766ce.
//
// Solidity: function pauseContract() returns(bool)
func (_Spin *SpinTransactor) PauseContract(opts *bind.TransactOpts) (*types.Transaction, error) {
	return _Spin.contract.Transact(opts, "pauseContract")
}

// PauseContract is a paid mutator transaction binding the contract method 0x439766ce.
//
// Solidity: function pauseContract() returns(bool)
func (_Spin *SpinSession) PauseContract() (*types.Transaction, error) {
	return _Spin.Contract.PauseContract(&_Spin.TransactOpts)
}

// PauseContract is a paid mutator transaction binding the contract method 0x439766ce.
//
// Solidity: function pauseContract() returns(bool)
func (_Spin *SpinTransactorSession) PauseContract() (*types.Transaction, error) {
	return _Spin.Contract.PauseContract(&_Spin.TransactOpts)
}

// RemoveAddressFromBlacklist is a paid mutator transaction binding the contract method 0x35e82f3a.
//
// Solidity: function removeAddressFromBlacklist(address addr) returns(bool success)
func (_Spin *SpinTransactor) RemoveAddressFromBlacklist(opts *bind.TransactOpts, addr common.Address) (*types.Transaction, error) {
	return _Spin.contract.Transact(opts, "removeAddressFromBlacklist", addr)
}

// RemoveAddressFromBlacklist is a paid mutator transaction binding the contract method 0x35e82f3a.
//
// Solidity: function removeAddressFromBlacklist(address addr) returns(bool success)
func (_Spin *SpinSession) RemoveAddressFromBlacklist(addr common.Address) (*types.Transaction, error) {
	return _Spin.Contract.RemoveAddressFromBlacklist(&_Spin.TransactOpts, addr)
}

// RemoveAddressFromBlacklist is a paid mutator transaction binding the contract method 0x35e82f3a.
//
// Solidity: function removeAddressFromBlacklist(address addr) returns(bool success)
func (_Spin *SpinTransactorSession) RemoveAddressFromBlacklist(addr common.Address) (*types.Transaction, error) {
	return _Spin.Contract.RemoveAddressFromBlacklist(&_Spin.TransactOpts, addr)
}

// RemoveAddressesFromBlacklist is a paid mutator transaction binding the contract method 0x32258794.
//
// Solidity: function removeAddressesFromBlacklist(address[] addrs) returns(bool success)
func (_Spin *SpinTransactor) RemoveAddressesFromBlacklist(opts *bind.TransactOpts, addrs []common.Address) (*types.Transaction, error) {
	return _Spin.contract.Transact(opts, "removeAddressesFromBlacklist", addrs)
}

// RemoveAddressesFromBlacklist is a paid mutator transaction binding the contract method 0x32258794.
//
// Solidity: function removeAddressesFromBlacklist(address[] addrs) returns(bool success)
func (_Spin *SpinSession) RemoveAddressesFromBlacklist(addrs []common.Address) (*types.Transaction, error) {
	return _Spin.Contract.RemoveAddressesFromBlacklist(&_Spin.TransactOpts, addrs)
}

// RemoveAddressesFromBlacklist is a paid mutator transaction binding the contract method 0x32258794.
//
// Solidity: function removeAddressesFromBlacklist(address[] addrs) returns(bool success)
func (_Spin *SpinTransactorSession) RemoveAddressesFromBlacklist(addrs []common.Address) (*types.Transaction, error) {
	return _Spin.Contract.RemoveAddressesFromBlacklist(&_Spin.TransactOpts, addrs)
}

// RenounceOwnership is a paid mutator transaction binding the contract method 0x715018a6.
//
// Solidity: function renounceOwnership() returns()
func (_Spin *SpinTransactor) RenounceOwnership(opts *bind.TransactOpts) (*types.Transaction, error) {
	return _Spin.contract.Transact(opts, "renounceOwnership")
}

// RenounceOwnership is a paid mutator transaction binding the contract method 0x715018a6.
//
// Solidity: function renounceOwnership() returns()
func (_Spin *SpinSession) RenounceOwnership() (*types.Transaction, error) {
	return _Spin.Contract.RenounceOwnership(&_Spin.TransactOpts)
}

// RenounceOwnership is a paid mutator transaction binding the contract method 0x715018a6.
//
// Solidity: function renounceOwnership() returns()
func (_Spin *SpinTransactorSession) RenounceOwnership() (*types.Transaction, error) {
	return _Spin.Contract.RenounceOwnership(&_Spin.TransactOpts)
}

// Transfer is a paid mutator transaction binding the contract method 0xa9059cbb.
//
// Solidity: function transfer(address _to, uint256 _value) returns(bool)
func (_Spin *SpinTransactor) Transfer(opts *bind.TransactOpts, _to common.Address, _value *big.Int) (*types.Transaction, error) {
	return _Spin.contract.Transact(opts, "transfer", _to, _value)
}

// Transfer is a paid mutator transaction binding the contract method 0xa9059cbb.
//
// Solidity: function transfer(address _to, uint256 _value) returns(bool)
func (_Spin *SpinSession) Transfer(_to common.Address, _value *big.Int) (*types.Transaction, error) {
	return _Spin.Contract.Transfer(&_Spin.TransactOpts, _to, _value)
}

// Transfer is a paid mutator transaction binding the contract method 0xa9059cbb.
//
// Solidity: function transfer(address _to, uint256 _value) returns(bool)
func (_Spin *SpinTransactorSession) Transfer(_to common.Address, _value *big.Int) (*types.Transaction, error) {
	return _Spin.Contract.Transfer(&_Spin.TransactOpts, _to, _value)
}

// TransferFrom is a paid mutator transaction binding the contract method 0x23b872dd.
//
// Solidity: function transferFrom(address _from, address _to, uint256 _value) returns(bool)
func (_Spin *SpinTransactor) TransferFrom(opts *bind.TransactOpts, _from common.Address, _to common.Address, _value *big.Int) (*types.Transaction, error) {
	return _Spin.contract.Transact(opts, "transferFrom", _from, _to, _value)
}

// TransferFrom is a paid mutator transaction binding the contract method 0x23b872dd.
//
// Solidity: function transferFrom(address _from, address _to, uint256 _value) returns(bool)
func (_Spin *SpinSession) TransferFrom(_from common.Address, _to common.Address, _value *big.Int) (*types.Transaction, error) {
	return _Spin.Contract.TransferFrom(&_Spin.TransactOpts, _from, _to, _value)
}

// TransferFrom is a paid mutator transaction binding the contract method 0x23b872dd.
//
// Solidity: function transferFrom(address _from, address _to, uint256 _value) returns(bool)
func (_Spin *SpinTransactorSession) TransferFrom(_from common.Address, _to common.Address, _value *big.Int) (*types.Transaction, error) {
	return _Spin.Contract.TransferFrom(&_Spin.TransactOpts, _from, _to, _value)
}

// TransferOwnership is a paid mutator transaction binding the contract method 0xf2fde38b.
//
// Solidity: function transferOwnership(address newOwner) returns()
func (_Spin *SpinTransactor) TransferOwnership(opts *bind.TransactOpts, newOwner common.Address) (*types.Transaction, error) {
	return _Spin.contract.Transact(opts, "transferOwnership", newOwner)
}

// TransferOwnership is a paid mutator transaction binding the contract method 0xf2fde38b.
//
// Solidity: function transferOwnership(address newOwner) returns()
func (_Spin *SpinSession) TransferOwnership(newOwner common.Address) (*types.Transaction, error) {
	return _Spin.Contract.TransferOwnership(&_Spin.TransactOpts, newOwner)
}

// TransferOwnership is a paid mutator transaction binding the contract method 0xf2fde38b.
//
// Solidity: function transferOwnership(address newOwner) returns()
func (_Spin *SpinTransactorSession) TransferOwnership(newOwner common.Address) (*types.Transaction, error) {
	return _Spin.Contract.TransferOwnership(&_Spin.TransactOpts, newOwner)
}

// UnpauseContract is a paid mutator transaction binding the contract method 0xb33712c5.
//
// Solidity: function unpauseContract() returns(bool)
func (_Spin *SpinTransactor) UnpauseContract(opts *bind.TransactOpts) (*types.Transaction, error) {
	return _Spin.contract.Transact(opts, "unpauseContract")
}

// UnpauseContract is a paid mutator transaction binding the contract method 0xb33712c5.
//
// Solidity: function unpauseContract() returns(bool)
func (_Spin *SpinSession) UnpauseContract() (*types.Transaction, error) {
	return _Spin.Contract.UnpauseContract(&_Spin.TransactOpts)
}

// UnpauseContract is a paid mutator transaction binding the contract method 0xb33712c5.
//
// Solidity: function unpauseContract() returns(bool)
func (_Spin *SpinTransactorSession) UnpauseContract() (*types.Transaction, error) {
	return _Spin.Contract.UnpauseContract(&_Spin.TransactOpts)
}

// SpinApprovalIterator is returned from FilterApproval and is used to iterate over the raw logs and unpacked data for Approval events raised by the Spin contract.
type SpinApprovalIterator struct {
	Event *SpinApproval // Event containing the contract specifics and raw log

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
func (it *SpinApprovalIterator) Next() bool {
	// If the iterator failed, stop iterating
	if it.fail != nil {
		return false
	}
	// If the iterator completed, deliver directly whatever's available
	if it.done {
		select {
		case log := <-it.logs:
			it.Event = new(SpinApproval)
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
		it.Event = new(SpinApproval)
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
func (it *SpinApprovalIterator) Error() error {
	return it.fail
}

// Close terminates the iteration process, releasing any pending underlying
// resources.
func (it *SpinApprovalIterator) Close() error {
	it.sub.Unsubscribe()
	return nil
}

// SpinApproval represents a Approval event raised by the Spin contract.
type SpinApproval struct {
	Owner   common.Address
	Spender common.Address
	Value   *big.Int
	Raw     types.Log // Blockchain specific contextual infos
}

// FilterApproval is a free log retrieval operation binding the contract event 0x8c5be1e5ebec7d5bd14f71427d1e84f3dd0314c0f7b2291e5b200ac8c7c3b925.
//
// Solidity: event Approval(address indexed owner, address indexed spender, uint256 value)
func (_Spin *SpinFilterer) FilterApproval(opts *bind.FilterOpts, owner []common.Address, spender []common.Address) (*SpinApprovalIterator, error) {

	var ownerRule []interface{}
	for _, ownerItem := range owner {
		ownerRule = append(ownerRule, ownerItem)
	}
	var spenderRule []interface{}
	for _, spenderItem := range spender {
		spenderRule = append(spenderRule, spenderItem)
	}

	logs, sub, err := _Spin.contract.FilterLogs(opts, "Approval", ownerRule, spenderRule)
	if err != nil {
		return nil, err
	}
	return &SpinApprovalIterator{contract: _Spin.contract, event: "Approval", logs: logs, sub: sub}, nil
}

// WatchApproval is a free log subscription operation binding the contract event 0x8c5be1e5ebec7d5bd14f71427d1e84f3dd0314c0f7b2291e5b200ac8c7c3b925.
//
// Solidity: event Approval(address indexed owner, address indexed spender, uint256 value)
func (_Spin *SpinFilterer) WatchApproval(opts *bind.WatchOpts, sink chan<- *SpinApproval, owner []common.Address, spender []common.Address) (event.Subscription, error) {

	var ownerRule []interface{}
	for _, ownerItem := range owner {
		ownerRule = append(ownerRule, ownerItem)
	}
	var spenderRule []interface{}
	for _, spenderItem := range spender {
		spenderRule = append(spenderRule, spenderItem)
	}

	logs, sub, err := _Spin.contract.WatchLogs(opts, "Approval", ownerRule, spenderRule)
	if err != nil {
		return nil, err
	}
	return event.NewSubscription(func(quit <-chan struct{}) error {
		defer sub.Unsubscribe()
		for {
			select {
			case log := <-logs:
				// New log arrived, parse the event and forward to the user
				event := new(SpinApproval)
				if err := _Spin.contract.UnpackLog(event, "Approval", log); err != nil {
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
func (_Spin *SpinFilterer) ParseApproval(log types.Log) (*SpinApproval, error) {
	event := new(SpinApproval)
	if err := _Spin.contract.UnpackLog(event, "Approval", log); err != nil {
		return nil, err
	}
	event.Raw = log
	return event, nil
}

// SpinBlacklistedAddressAddedIterator is returned from FilterBlacklistedAddressAdded and is used to iterate over the raw logs and unpacked data for BlacklistedAddressAdded events raised by the Spin contract.
type SpinBlacklistedAddressAddedIterator struct {
	Event *SpinBlacklistedAddressAdded // Event containing the contract specifics and raw log

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
func (it *SpinBlacklistedAddressAddedIterator) Next() bool {
	// If the iterator failed, stop iterating
	if it.fail != nil {
		return false
	}
	// If the iterator completed, deliver directly whatever's available
	if it.done {
		select {
		case log := <-it.logs:
			it.Event = new(SpinBlacklistedAddressAdded)
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
		it.Event = new(SpinBlacklistedAddressAdded)
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
func (it *SpinBlacklistedAddressAddedIterator) Error() error {
	return it.fail
}

// Close terminates the iteration process, releasing any pending underlying
// resources.
func (it *SpinBlacklistedAddressAddedIterator) Close() error {
	it.sub.Unsubscribe()
	return nil
}

// SpinBlacklistedAddressAdded represents a BlacklistedAddressAdded event raised by the Spin contract.
type SpinBlacklistedAddressAdded struct {
	Addr common.Address
	Raw  types.Log // Blockchain specific contextual infos
}

// FilterBlacklistedAddressAdded is a free log retrieval operation binding the contract event 0xee71faa2d1e96ac74ee4023d6ffa8abfa43b7648f51e3dbd8ec561823e9df132.
//
// Solidity: event BlacklistedAddressAdded(address addr)
func (_Spin *SpinFilterer) FilterBlacklistedAddressAdded(opts *bind.FilterOpts) (*SpinBlacklistedAddressAddedIterator, error) {

	logs, sub, err := _Spin.contract.FilterLogs(opts, "BlacklistedAddressAdded")
	if err != nil {
		return nil, err
	}
	return &SpinBlacklistedAddressAddedIterator{contract: _Spin.contract, event: "BlacklistedAddressAdded", logs: logs, sub: sub}, nil
}

// WatchBlacklistedAddressAdded is a free log subscription operation binding the contract event 0xee71faa2d1e96ac74ee4023d6ffa8abfa43b7648f51e3dbd8ec561823e9df132.
//
// Solidity: event BlacklistedAddressAdded(address addr)
func (_Spin *SpinFilterer) WatchBlacklistedAddressAdded(opts *bind.WatchOpts, sink chan<- *SpinBlacklistedAddressAdded) (event.Subscription, error) {

	logs, sub, err := _Spin.contract.WatchLogs(opts, "BlacklistedAddressAdded")
	if err != nil {
		return nil, err
	}
	return event.NewSubscription(func(quit <-chan struct{}) error {
		defer sub.Unsubscribe()
		for {
			select {
			case log := <-logs:
				// New log arrived, parse the event and forward to the user
				event := new(SpinBlacklistedAddressAdded)
				if err := _Spin.contract.UnpackLog(event, "BlacklistedAddressAdded", log); err != nil {
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

// ParseBlacklistedAddressAdded is a log parse operation binding the contract event 0xee71faa2d1e96ac74ee4023d6ffa8abfa43b7648f51e3dbd8ec561823e9df132.
//
// Solidity: event BlacklistedAddressAdded(address addr)
func (_Spin *SpinFilterer) ParseBlacklistedAddressAdded(log types.Log) (*SpinBlacklistedAddressAdded, error) {
	event := new(SpinBlacklistedAddressAdded)
	if err := _Spin.contract.UnpackLog(event, "BlacklistedAddressAdded", log); err != nil {
		return nil, err
	}
	event.Raw = log
	return event, nil
}

// SpinBlacklistedAddressRemovedIterator is returned from FilterBlacklistedAddressRemoved and is used to iterate over the raw logs and unpacked data for BlacklistedAddressRemoved events raised by the Spin contract.
type SpinBlacklistedAddressRemovedIterator struct {
	Event *SpinBlacklistedAddressRemoved // Event containing the contract specifics and raw log

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
func (it *SpinBlacklistedAddressRemovedIterator) Next() bool {
	// If the iterator failed, stop iterating
	if it.fail != nil {
		return false
	}
	// If the iterator completed, deliver directly whatever's available
	if it.done {
		select {
		case log := <-it.logs:
			it.Event = new(SpinBlacklistedAddressRemoved)
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
		it.Event = new(SpinBlacklistedAddressRemoved)
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
func (it *SpinBlacklistedAddressRemovedIterator) Error() error {
	return it.fail
}

// Close terminates the iteration process, releasing any pending underlying
// resources.
func (it *SpinBlacklistedAddressRemovedIterator) Close() error {
	it.sub.Unsubscribe()
	return nil
}

// SpinBlacklistedAddressRemoved represents a BlacklistedAddressRemoved event raised by the Spin contract.
type SpinBlacklistedAddressRemoved struct {
	Addr common.Address
	Raw  types.Log // Blockchain specific contextual infos
}

// FilterBlacklistedAddressRemoved is a free log retrieval operation binding the contract event 0xb9b02d6ef3069c468ac99865bad0d84ec0cf34671cb26053e5e47d415ae17564.
//
// Solidity: event BlacklistedAddressRemoved(address addr)
func (_Spin *SpinFilterer) FilterBlacklistedAddressRemoved(opts *bind.FilterOpts) (*SpinBlacklistedAddressRemovedIterator, error) {

	logs, sub, err := _Spin.contract.FilterLogs(opts, "BlacklistedAddressRemoved")
	if err != nil {
		return nil, err
	}
	return &SpinBlacklistedAddressRemovedIterator{contract: _Spin.contract, event: "BlacklistedAddressRemoved", logs: logs, sub: sub}, nil
}

// WatchBlacklistedAddressRemoved is a free log subscription operation binding the contract event 0xb9b02d6ef3069c468ac99865bad0d84ec0cf34671cb26053e5e47d415ae17564.
//
// Solidity: event BlacklistedAddressRemoved(address addr)
func (_Spin *SpinFilterer) WatchBlacklistedAddressRemoved(opts *bind.WatchOpts, sink chan<- *SpinBlacklistedAddressRemoved) (event.Subscription, error) {

	logs, sub, err := _Spin.contract.WatchLogs(opts, "BlacklistedAddressRemoved")
	if err != nil {
		return nil, err
	}
	return event.NewSubscription(func(quit <-chan struct{}) error {
		defer sub.Unsubscribe()
		for {
			select {
			case log := <-logs:
				// New log arrived, parse the event and forward to the user
				event := new(SpinBlacklistedAddressRemoved)
				if err := _Spin.contract.UnpackLog(event, "BlacklistedAddressRemoved", log); err != nil {
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

// ParseBlacklistedAddressRemoved is a log parse operation binding the contract event 0xb9b02d6ef3069c468ac99865bad0d84ec0cf34671cb26053e5e47d415ae17564.
//
// Solidity: event BlacklistedAddressRemoved(address addr)
func (_Spin *SpinFilterer) ParseBlacklistedAddressRemoved(log types.Log) (*SpinBlacklistedAddressRemoved, error) {
	event := new(SpinBlacklistedAddressRemoved)
	if err := _Spin.contract.UnpackLog(event, "BlacklistedAddressRemoved", log); err != nil {
		return nil, err
	}
	event.Raw = log
	return event, nil
}

// SpinOwnershipTransferredIterator is returned from FilterOwnershipTransferred and is used to iterate over the raw logs and unpacked data for OwnershipTransferred events raised by the Spin contract.
type SpinOwnershipTransferredIterator struct {
	Event *SpinOwnershipTransferred // Event containing the contract specifics and raw log

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
func (it *SpinOwnershipTransferredIterator) Next() bool {
	// If the iterator failed, stop iterating
	if it.fail != nil {
		return false
	}
	// If the iterator completed, deliver directly whatever's available
	if it.done {
		select {
		case log := <-it.logs:
			it.Event = new(SpinOwnershipTransferred)
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
		it.Event = new(SpinOwnershipTransferred)
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
func (it *SpinOwnershipTransferredIterator) Error() error {
	return it.fail
}

// Close terminates the iteration process, releasing any pending underlying
// resources.
func (it *SpinOwnershipTransferredIterator) Close() error {
	it.sub.Unsubscribe()
	return nil
}

// SpinOwnershipTransferred represents a OwnershipTransferred event raised by the Spin contract.
type SpinOwnershipTransferred struct {
	PreviousOwner common.Address
	NewOwner      common.Address
	Raw           types.Log // Blockchain specific contextual infos
}

// FilterOwnershipTransferred is a free log retrieval operation binding the contract event 0x8be0079c531659141344cd1fd0a4f28419497f9722a3daafe3b4186f6b6457e0.
//
// Solidity: event OwnershipTransferred(address indexed previousOwner, address indexed newOwner)
func (_Spin *SpinFilterer) FilterOwnershipTransferred(opts *bind.FilterOpts, previousOwner []common.Address, newOwner []common.Address) (*SpinOwnershipTransferredIterator, error) {

	var previousOwnerRule []interface{}
	for _, previousOwnerItem := range previousOwner {
		previousOwnerRule = append(previousOwnerRule, previousOwnerItem)
	}
	var newOwnerRule []interface{}
	for _, newOwnerItem := range newOwner {
		newOwnerRule = append(newOwnerRule, newOwnerItem)
	}

	logs, sub, err := _Spin.contract.FilterLogs(opts, "OwnershipTransferred", previousOwnerRule, newOwnerRule)
	if err != nil {
		return nil, err
	}
	return &SpinOwnershipTransferredIterator{contract: _Spin.contract, event: "OwnershipTransferred", logs: logs, sub: sub}, nil
}

// WatchOwnershipTransferred is a free log subscription operation binding the contract event 0x8be0079c531659141344cd1fd0a4f28419497f9722a3daafe3b4186f6b6457e0.
//
// Solidity: event OwnershipTransferred(address indexed previousOwner, address indexed newOwner)
func (_Spin *SpinFilterer) WatchOwnershipTransferred(opts *bind.WatchOpts, sink chan<- *SpinOwnershipTransferred, previousOwner []common.Address, newOwner []common.Address) (event.Subscription, error) {

	var previousOwnerRule []interface{}
	for _, previousOwnerItem := range previousOwner {
		previousOwnerRule = append(previousOwnerRule, previousOwnerItem)
	}
	var newOwnerRule []interface{}
	for _, newOwnerItem := range newOwner {
		newOwnerRule = append(newOwnerRule, newOwnerItem)
	}

	logs, sub, err := _Spin.contract.WatchLogs(opts, "OwnershipTransferred", previousOwnerRule, newOwnerRule)
	if err != nil {
		return nil, err
	}
	return event.NewSubscription(func(quit <-chan struct{}) error {
		defer sub.Unsubscribe()
		for {
			select {
			case log := <-logs:
				// New log arrived, parse the event and forward to the user
				event := new(SpinOwnershipTransferred)
				if err := _Spin.contract.UnpackLog(event, "OwnershipTransferred", log); err != nil {
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
func (_Spin *SpinFilterer) ParseOwnershipTransferred(log types.Log) (*SpinOwnershipTransferred, error) {
	event := new(SpinOwnershipTransferred)
	if err := _Spin.contract.UnpackLog(event, "OwnershipTransferred", log); err != nil {
		return nil, err
	}
	event.Raw = log
	return event, nil
}

// SpinPausedIterator is returned from FilterPaused and is used to iterate over the raw logs and unpacked data for Paused events raised by the Spin contract.
type SpinPausedIterator struct {
	Event *SpinPaused // Event containing the contract specifics and raw log

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
func (it *SpinPausedIterator) Next() bool {
	// If the iterator failed, stop iterating
	if it.fail != nil {
		return false
	}
	// If the iterator completed, deliver directly whatever's available
	if it.done {
		select {
		case log := <-it.logs:
			it.Event = new(SpinPaused)
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
		it.Event = new(SpinPaused)
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
func (it *SpinPausedIterator) Error() error {
	return it.fail
}

// Close terminates the iteration process, releasing any pending underlying
// resources.
func (it *SpinPausedIterator) Close() error {
	it.sub.Unsubscribe()
	return nil
}

// SpinPaused represents a Paused event raised by the Spin contract.
type SpinPaused struct {
	Account common.Address
	Raw     types.Log // Blockchain specific contextual infos
}

// FilterPaused is a free log retrieval operation binding the contract event 0x62e78cea01bee320cd4e420270b5ea74000d11b0c9f74754ebdbfc544b05a258.
//
// Solidity: event Paused(address account)
func (_Spin *SpinFilterer) FilterPaused(opts *bind.FilterOpts) (*SpinPausedIterator, error) {

	logs, sub, err := _Spin.contract.FilterLogs(opts, "Paused")
	if err != nil {
		return nil, err
	}
	return &SpinPausedIterator{contract: _Spin.contract, event: "Paused", logs: logs, sub: sub}, nil
}

// WatchPaused is a free log subscription operation binding the contract event 0x62e78cea01bee320cd4e420270b5ea74000d11b0c9f74754ebdbfc544b05a258.
//
// Solidity: event Paused(address account)
func (_Spin *SpinFilterer) WatchPaused(opts *bind.WatchOpts, sink chan<- *SpinPaused) (event.Subscription, error) {

	logs, sub, err := _Spin.contract.WatchLogs(opts, "Paused")
	if err != nil {
		return nil, err
	}
	return event.NewSubscription(func(quit <-chan struct{}) error {
		defer sub.Unsubscribe()
		for {
			select {
			case log := <-logs:
				// New log arrived, parse the event and forward to the user
				event := new(SpinPaused)
				if err := _Spin.contract.UnpackLog(event, "Paused", log); err != nil {
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
func (_Spin *SpinFilterer) ParsePaused(log types.Log) (*SpinPaused, error) {
	event := new(SpinPaused)
	if err := _Spin.contract.UnpackLog(event, "Paused", log); err != nil {
		return nil, err
	}
	event.Raw = log
	return event, nil
}

// SpinTransferIterator is returned from FilterTransfer and is used to iterate over the raw logs and unpacked data for Transfer events raised by the Spin contract.
type SpinTransferIterator struct {
	Event *SpinTransfer // Event containing the contract specifics and raw log

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
func (it *SpinTransferIterator) Next() bool {
	// If the iterator failed, stop iterating
	if it.fail != nil {
		return false
	}
	// If the iterator completed, deliver directly whatever's available
	if it.done {
		select {
		case log := <-it.logs:
			it.Event = new(SpinTransfer)
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
		it.Event = new(SpinTransfer)
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
func (it *SpinTransferIterator) Error() error {
	return it.fail
}

// Close terminates the iteration process, releasing any pending underlying
// resources.
func (it *SpinTransferIterator) Close() error {
	it.sub.Unsubscribe()
	return nil
}

// SpinTransfer represents a Transfer event raised by the Spin contract.
type SpinTransfer struct {
	From  common.Address
	To    common.Address
	Value *big.Int
	Raw   types.Log // Blockchain specific contextual infos
}

// FilterTransfer is a free log retrieval operation binding the contract event 0xddf252ad1be2c89b69c2b068fc378daa952ba7f163c4a11628f55a4df523b3ef.
//
// Solidity: event Transfer(address indexed from, address indexed to, uint256 value)
func (_Spin *SpinFilterer) FilterTransfer(opts *bind.FilterOpts, from []common.Address, to []common.Address) (*SpinTransferIterator, error) {

	var fromRule []interface{}
	for _, fromItem := range from {
		fromRule = append(fromRule, fromItem)
	}
	var toRule []interface{}
	for _, toItem := range to {
		toRule = append(toRule, toItem)
	}

	logs, sub, err := _Spin.contract.FilterLogs(opts, "Transfer", fromRule, toRule)
	if err != nil {
		return nil, err
	}
	return &SpinTransferIterator{contract: _Spin.contract, event: "Transfer", logs: logs, sub: sub}, nil
}

// WatchTransfer is a free log subscription operation binding the contract event 0xddf252ad1be2c89b69c2b068fc378daa952ba7f163c4a11628f55a4df523b3ef.
//
// Solidity: event Transfer(address indexed from, address indexed to, uint256 value)
func (_Spin *SpinFilterer) WatchTransfer(opts *bind.WatchOpts, sink chan<- *SpinTransfer, from []common.Address, to []common.Address) (event.Subscription, error) {

	var fromRule []interface{}
	for _, fromItem := range from {
		fromRule = append(fromRule, fromItem)
	}
	var toRule []interface{}
	for _, toItem := range to {
		toRule = append(toRule, toItem)
	}

	logs, sub, err := _Spin.contract.WatchLogs(opts, "Transfer", fromRule, toRule)
	if err != nil {
		return nil, err
	}
	return event.NewSubscription(func(quit <-chan struct{}) error {
		defer sub.Unsubscribe()
		for {
			select {
			case log := <-logs:
				// New log arrived, parse the event and forward to the user
				event := new(SpinTransfer)
				if err := _Spin.contract.UnpackLog(event, "Transfer", log); err != nil {
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
func (_Spin *SpinFilterer) ParseTransfer(log types.Log) (*SpinTransfer, error) {
	event := new(SpinTransfer)
	if err := _Spin.contract.UnpackLog(event, "Transfer", log); err != nil {
		return nil, err
	}
	event.Raw = log
	return event, nil
}

// SpinUnpausedIterator is returned from FilterUnpaused and is used to iterate over the raw logs and unpacked data for Unpaused events raised by the Spin contract.
type SpinUnpausedIterator struct {
	Event *SpinUnpaused // Event containing the contract specifics and raw log

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
func (it *SpinUnpausedIterator) Next() bool {
	// If the iterator failed, stop iterating
	if it.fail != nil {
		return false
	}
	// If the iterator completed, deliver directly whatever's available
	if it.done {
		select {
		case log := <-it.logs:
			it.Event = new(SpinUnpaused)
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
		it.Event = new(SpinUnpaused)
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
func (it *SpinUnpausedIterator) Error() error {
	return it.fail
}

// Close terminates the iteration process, releasing any pending underlying
// resources.
func (it *SpinUnpausedIterator) Close() error {
	it.sub.Unsubscribe()
	return nil
}

// SpinUnpaused represents a Unpaused event raised by the Spin contract.
type SpinUnpaused struct {
	Account common.Address
	Raw     types.Log // Blockchain specific contextual infos
}

// FilterUnpaused is a free log retrieval operation binding the contract event 0x5db9ee0a495bf2e6ff9c91a7834c1ba4fdd244a5e8aa4e537bd38aeae4b073aa.
//
// Solidity: event Unpaused(address account)
func (_Spin *SpinFilterer) FilterUnpaused(opts *bind.FilterOpts) (*SpinUnpausedIterator, error) {

	logs, sub, err := _Spin.contract.FilterLogs(opts, "Unpaused")
	if err != nil {
		return nil, err
	}
	return &SpinUnpausedIterator{contract: _Spin.contract, event: "Unpaused", logs: logs, sub: sub}, nil
}

// WatchUnpaused is a free log subscription operation binding the contract event 0x5db9ee0a495bf2e6ff9c91a7834c1ba4fdd244a5e8aa4e537bd38aeae4b073aa.
//
// Solidity: event Unpaused(address account)
func (_Spin *SpinFilterer) WatchUnpaused(opts *bind.WatchOpts, sink chan<- *SpinUnpaused) (event.Subscription, error) {

	logs, sub, err := _Spin.contract.WatchLogs(opts, "Unpaused")
	if err != nil {
		return nil, err
	}
	return event.NewSubscription(func(quit <-chan struct{}) error {
		defer sub.Unsubscribe()
		for {
			select {
			case log := <-logs:
				// New log arrived, parse the event and forward to the user
				event := new(SpinUnpaused)
				if err := _Spin.contract.UnpackLog(event, "Unpaused", log); err != nil {
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
func (_Spin *SpinFilterer) ParseUnpaused(log types.Log) (*SpinUnpaused, error) {
	event := new(SpinUnpaused)
	if err := _Spin.contract.UnpackLog(event, "Unpaused", log); err != nil {
		return nil, err
	}
	event.Raw = log
	return event, nil
}
