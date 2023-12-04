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

// MainMetaData contains all meta data concerning the Main contract.
var MainMetaData = &bind.MetaData{
	ABI: "[{\"inputs\":[{\"internalType\":\"address\",\"name\":\"_rewardsToken\",\"type\":\"address\"},{\"internalType\":\"address\",\"name\":\"_stakingToken\",\"type\":\"address\"}],\"stateMutability\":\"nonpayable\",\"type\":\"constructor\"},{\"anonymous\":false,\"inputs\":[{\"indexed\":true,\"internalType\":\"address\",\"name\":\"previousOwner\",\"type\":\"address\"},{\"indexed\":true,\"internalType\":\"address\",\"name\":\"newOwner\",\"type\":\"address\"}],\"name\":\"OwnershipTransferred\",\"type\":\"event\"},{\"anonymous\":false,\"inputs\":[{\"indexed\":false,\"internalType\":\"address\",\"name\":\"token\",\"type\":\"address\"},{\"indexed\":false,\"internalType\":\"uint256\",\"name\":\"amount\",\"type\":\"uint256\"}],\"name\":\"Recovered\",\"type\":\"event\"},{\"anonymous\":false,\"inputs\":[{\"indexed\":false,\"internalType\":\"uint256\",\"name\":\"reward\",\"type\":\"uint256\"}],\"name\":\"RewardAdded\",\"type\":\"event\"},{\"anonymous\":false,\"inputs\":[{\"indexed\":true,\"internalType\":\"address\",\"name\":\"user\",\"type\":\"address\"},{\"indexed\":false,\"internalType\":\"uint256\",\"name\":\"reward\",\"type\":\"uint256\"}],\"name\":\"RewardPaid\",\"type\":\"event\"},{\"anonymous\":false,\"inputs\":[{\"indexed\":false,\"internalType\":\"uint256\",\"name\":\"newDuration\",\"type\":\"uint256\"}],\"name\":\"RewardsDurationUpdated\",\"type\":\"event\"},{\"anonymous\":false,\"inputs\":[{\"indexed\":true,\"internalType\":\"address\",\"name\":\"user\",\"type\":\"address\"},{\"indexed\":false,\"internalType\":\"uint256\",\"name\":\"amount\",\"type\":\"uint256\"}],\"name\":\"Staked\",\"type\":\"event\"},{\"anonymous\":false,\"inputs\":[{\"indexed\":false,\"internalType\":\"uint256\",\"name\":\"newDuration\",\"type\":\"uint256\"}],\"name\":\"UnlockDurationUpdated\",\"type\":\"event\"},{\"anonymous\":false,\"inputs\":[{\"indexed\":true,\"internalType\":\"address\",\"name\":\"user\",\"type\":\"address\"},{\"indexed\":false,\"internalType\":\"uint256\",\"name\":\"amount\",\"type\":\"uint256\"}],\"name\":\"Withdrawn\",\"type\":\"event\"},{\"inputs\":[{\"internalType\":\"address\",\"name\":\"account\",\"type\":\"address\"}],\"name\":\"balanceOf\",\"outputs\":[{\"internalType\":\"uint256\",\"name\":\"\",\"type\":\"uint256\"}],\"stateMutability\":\"view\",\"type\":\"function\"},{\"inputs\":[{\"internalType\":\"address\",\"name\":\"account\",\"type\":\"address\"}],\"name\":\"earned\",\"outputs\":[{\"internalType\":\"uint256\",\"name\":\"\",\"type\":\"uint256\"}],\"stateMutability\":\"view\",\"type\":\"function\"},{\"inputs\":[],\"name\":\"exit\",\"outputs\":[],\"stateMutability\":\"nonpayable\",\"type\":\"function\"},{\"inputs\":[],\"name\":\"getReward\",\"outputs\":[],\"stateMutability\":\"nonpayable\",\"type\":\"function\"},{\"inputs\":[],\"name\":\"getRewardForDuration\",\"outputs\":[{\"internalType\":\"uint256\",\"name\":\"\",\"type\":\"uint256\"}],\"stateMutability\":\"view\",\"type\":\"function\"},{\"inputs\":[],\"name\":\"lastTimeRewardApplicable\",\"outputs\":[{\"internalType\":\"uint256\",\"name\":\"\",\"type\":\"uint256\"}],\"stateMutability\":\"view\",\"type\":\"function\"},{\"inputs\":[],\"name\":\"lastUpdateTime\",\"outputs\":[{\"internalType\":\"uint256\",\"name\":\"\",\"type\":\"uint256\"}],\"stateMutability\":\"view\",\"type\":\"function\"},{\"inputs\":[{\"internalType\":\"uint256\",\"name\":\"reward\",\"type\":\"uint256\"}],\"name\":\"notifyRewardAmount\",\"outputs\":[],\"stateMutability\":\"nonpayable\",\"type\":\"function\"},{\"inputs\":[],\"name\":\"owner\",\"outputs\":[{\"internalType\":\"address\",\"name\":\"\",\"type\":\"address\"}],\"stateMutability\":\"view\",\"type\":\"function\"},{\"inputs\":[],\"name\":\"periodFinish\",\"outputs\":[{\"internalType\":\"uint256\",\"name\":\"\",\"type\":\"uint256\"}],\"stateMutability\":\"view\",\"type\":\"function\"},{\"inputs\":[{\"internalType\":\"address\",\"name\":\"tokenAddress\",\"type\":\"address\"},{\"internalType\":\"uint256\",\"name\":\"tokenAmount\",\"type\":\"uint256\"}],\"name\":\"recoverERC20\",\"outputs\":[],\"stateMutability\":\"nonpayable\",\"type\":\"function\"},{\"inputs\":[],\"name\":\"renounceOwnership\",\"outputs\":[],\"stateMutability\":\"nonpayable\",\"type\":\"function\"},{\"inputs\":[],\"name\":\"rewardPerToken\",\"outputs\":[{\"internalType\":\"uint256\",\"name\":\"\",\"type\":\"uint256\"}],\"stateMutability\":\"view\",\"type\":\"function\"},{\"inputs\":[],\"name\":\"rewardPerTokenStored\",\"outputs\":[{\"internalType\":\"uint256\",\"name\":\"\",\"type\":\"uint256\"}],\"stateMutability\":\"view\",\"type\":\"function\"},{\"inputs\":[],\"name\":\"rewardRate\",\"outputs\":[{\"internalType\":\"uint256\",\"name\":\"\",\"type\":\"uint256\"}],\"stateMutability\":\"view\",\"type\":\"function\"},{\"inputs\":[{\"internalType\":\"address\",\"name\":\"\",\"type\":\"address\"}],\"name\":\"rewards\",\"outputs\":[{\"internalType\":\"uint256\",\"name\":\"\",\"type\":\"uint256\"}],\"stateMutability\":\"view\",\"type\":\"function\"},{\"inputs\":[],\"name\":\"rewardsDuration\",\"outputs\":[{\"internalType\":\"uint256\",\"name\":\"\",\"type\":\"uint256\"}],\"stateMutability\":\"view\",\"type\":\"function\"},{\"inputs\":[],\"name\":\"rewardsToken\",\"outputs\":[{\"internalType\":\"contractIBEP20\",\"name\":\"\",\"type\":\"address\"}],\"stateMutability\":\"view\",\"type\":\"function\"},{\"inputs\":[{\"internalType\":\"uint256\",\"name\":\"_rewardsDuration\",\"type\":\"uint256\"}],\"name\":\"setRewardsDuration\",\"outputs\":[],\"stateMutability\":\"nonpayable\",\"type\":\"function\"},{\"inputs\":[{\"internalType\":\"uint256\",\"name\":\"_unlockDuration\",\"type\":\"uint256\"}],\"name\":\"setUnlockDuration\",\"outputs\":[],\"stateMutability\":\"nonpayable\",\"type\":\"function\"},{\"inputs\":[{\"internalType\":\"uint256\",\"name\":\"amount\",\"type\":\"uint256\"}],\"name\":\"stake\",\"outputs\":[],\"stateMutability\":\"nonpayable\",\"type\":\"function\"},{\"inputs\":[],\"name\":\"stakingToken\",\"outputs\":[{\"internalType\":\"contractIBEP20\",\"name\":\"\",\"type\":\"address\"}],\"stateMutability\":\"view\",\"type\":\"function\"},{\"inputs\":[],\"name\":\"totalRewardAdded\",\"outputs\":[{\"internalType\":\"uint256\",\"name\":\"\",\"type\":\"uint256\"}],\"stateMutability\":\"view\",\"type\":\"function\"},{\"inputs\":[],\"name\":\"totalStaked\",\"outputs\":[{\"internalType\":\"uint256\",\"name\":\"\",\"type\":\"uint256\"}],\"stateMutability\":\"view\",\"type\":\"function\"},{\"inputs\":[{\"internalType\":\"address\",\"name\":\"newOwner\",\"type\":\"address\"}],\"name\":\"transferOwnership\",\"outputs\":[],\"stateMutability\":\"nonpayable\",\"type\":\"function\"},{\"inputs\":[{\"internalType\":\"address\",\"name\":\"account\",\"type\":\"address\"}],\"name\":\"unstakable\",\"outputs\":[{\"internalType\":\"bool\",\"name\":\"\",\"type\":\"bool\"}],\"stateMutability\":\"view\",\"type\":\"function\"},{\"inputs\":[{\"internalType\":\"uint256\",\"name\":\"amount\",\"type\":\"uint256\"}],\"name\":\"unstake\",\"outputs\":[],\"stateMutability\":\"nonpayable\",\"type\":\"function\"},{\"inputs\":[{\"internalType\":\"address\",\"name\":\"\",\"type\":\"address\"}],\"name\":\"userRewardPerTokenPaid\",\"outputs\":[{\"internalType\":\"uint256\",\"name\":\"\",\"type\":\"uint256\"}],\"stateMutability\":\"view\",\"type\":\"function\"}]",
}

// MainABI is the input ABI used to generate the binding from.
// Deprecated: Use MainMetaData.ABI instead.
var MainABI = MainMetaData.ABI

// Main is an auto generated Go binding around an Ethereum contract.
type Main struct {
	MainCaller     // Read-only binding to the contract
	MainTransactor // Write-only binding to the contract
	MainFilterer   // Log filterer for contract events
}

// MainCaller is an auto generated read-only Go binding around an Ethereum contract.
type MainCaller struct {
	contract *bind.BoundContract // Generic contract wrapper for the low level calls
}

// MainTransactor is an auto generated write-only Go binding around an Ethereum contract.
type MainTransactor struct {
	contract *bind.BoundContract // Generic contract wrapper for the low level calls
}

// MainFilterer is an auto generated log filtering Go binding around an Ethereum contract events.
type MainFilterer struct {
	contract *bind.BoundContract // Generic contract wrapper for the low level calls
}

// MainSession is an auto generated Go binding around an Ethereum contract,
// with pre-set call and transact options.
type MainSession struct {
	Contract     *Main             // Generic contract binding to set the session for
	CallOpts     bind.CallOpts     // Call options to use throughout this session
	TransactOpts bind.TransactOpts // Transaction auth options to use throughout this session
}

// MainCallerSession is an auto generated read-only Go binding around an Ethereum contract,
// with pre-set call options.
type MainCallerSession struct {
	Contract *MainCaller   // Generic contract caller binding to set the session for
	CallOpts bind.CallOpts // Call options to use throughout this session
}

// MainTransactorSession is an auto generated write-only Go binding around an Ethereum contract,
// with pre-set transact options.
type MainTransactorSession struct {
	Contract     *MainTransactor   // Generic contract transactor binding to set the session for
	TransactOpts bind.TransactOpts // Transaction auth options to use throughout this session
}

// MainRaw is an auto generated low-level Go binding around an Ethereum contract.
type MainRaw struct {
	Contract *Main // Generic contract binding to access the raw methods on
}

// MainCallerRaw is an auto generated low-level read-only Go binding around an Ethereum contract.
type MainCallerRaw struct {
	Contract *MainCaller // Generic read-only contract binding to access the raw methods on
}

// MainTransactorRaw is an auto generated low-level write-only Go binding around an Ethereum contract.
type MainTransactorRaw struct {
	Contract *MainTransactor // Generic write-only contract binding to access the raw methods on
}

// NewMain creates a new instance of Main, bound to a specific deployed contract.
func NewMain(address common.Address, backend bind.ContractBackend) (*Main, error) {
	contract, err := bindMain(address, backend, backend, backend)
	if err != nil {
		return nil, err
	}
	return &Main{MainCaller: MainCaller{contract: contract}, MainTransactor: MainTransactor{contract: contract}, MainFilterer: MainFilterer{contract: contract}}, nil
}

// NewMainCaller creates a new read-only instance of Main, bound to a specific deployed contract.
func NewMainCaller(address common.Address, caller bind.ContractCaller) (*MainCaller, error) {
	contract, err := bindMain(address, caller, nil, nil)
	if err != nil {
		return nil, err
	}
	return &MainCaller{contract: contract}, nil
}

// NewMainTransactor creates a new write-only instance of Main, bound to a specific deployed contract.
func NewMainTransactor(address common.Address, transactor bind.ContractTransactor) (*MainTransactor, error) {
	contract, err := bindMain(address, nil, transactor, nil)
	if err != nil {
		return nil, err
	}
	return &MainTransactor{contract: contract}, nil
}

// NewMainFilterer creates a new log filterer instance of Main, bound to a specific deployed contract.
func NewMainFilterer(address common.Address, filterer bind.ContractFilterer) (*MainFilterer, error) {
	contract, err := bindMain(address, nil, nil, filterer)
	if err != nil {
		return nil, err
	}
	return &MainFilterer{contract: contract}, nil
}

// bindMain binds a generic wrapper to an already deployed contract.
func bindMain(address common.Address, caller bind.ContractCaller, transactor bind.ContractTransactor, filterer bind.ContractFilterer) (*bind.BoundContract, error) {
	parsed, err := MainMetaData.GetAbi()
	if err != nil {
		return nil, err
	}
	return bind.NewBoundContract(address, *parsed, caller, transactor, filterer), nil
}

// Call invokes the (constant) contract method with params as input values and
// sets the output to result. The result type might be a single field for simple
// returns, a slice of interfaces for anonymous returns and a struct for named
// returns.
func (_Main *MainRaw) Call(opts *bind.CallOpts, result *[]interface{}, method string, params ...interface{}) error {
	return _Main.Contract.MainCaller.contract.Call(opts, result, method, params...)
}

// Transfer initiates a plain transaction to move funds to the contract, calling
// its default method if one is available.
func (_Main *MainRaw) Transfer(opts *bind.TransactOpts) (*types.Transaction, error) {
	return _Main.Contract.MainTransactor.contract.Transfer(opts)
}

// Transact invokes the (paid) contract method with params as input values.
func (_Main *MainRaw) Transact(opts *bind.TransactOpts, method string, params ...interface{}) (*types.Transaction, error) {
	return _Main.Contract.MainTransactor.contract.Transact(opts, method, params...)
}

// Call invokes the (constant) contract method with params as input values and
// sets the output to result. The result type might be a single field for simple
// returns, a slice of interfaces for anonymous returns and a struct for named
// returns.
func (_Main *MainCallerRaw) Call(opts *bind.CallOpts, result *[]interface{}, method string, params ...interface{}) error {
	return _Main.Contract.contract.Call(opts, result, method, params...)
}

// Transfer initiates a plain transaction to move funds to the contract, calling
// its default method if one is available.
func (_Main *MainTransactorRaw) Transfer(opts *bind.TransactOpts) (*types.Transaction, error) {
	return _Main.Contract.contract.Transfer(opts)
}

// Transact invokes the (paid) contract method with params as input values.
func (_Main *MainTransactorRaw) Transact(opts *bind.TransactOpts, method string, params ...interface{}) (*types.Transaction, error) {
	return _Main.Contract.contract.Transact(opts, method, params...)
}

// BalanceOf is a free data retrieval call binding the contract method 0x70a08231.
//
// Solidity: function balanceOf(address account) view returns(uint256)
func (_Main *MainCaller) BalanceOf(opts *bind.CallOpts, account common.Address) (*big.Int, error) {
	var out []interface{}
	err := _Main.contract.Call(opts, &out, "balanceOf", account)

	if err != nil {
		return *new(*big.Int), err
	}

	out0 := *abi.ConvertType(out[0], new(*big.Int)).(**big.Int)

	return out0, err

}

// BalanceOf is a free data retrieval call binding the contract method 0x70a08231.
//
// Solidity: function balanceOf(address account) view returns(uint256)
func (_Main *MainSession) BalanceOf(account common.Address) (*big.Int, error) {
	return _Main.Contract.BalanceOf(&_Main.CallOpts, account)
}

// BalanceOf is a free data retrieval call binding the contract method 0x70a08231.
//
// Solidity: function balanceOf(address account) view returns(uint256)
func (_Main *MainCallerSession) BalanceOf(account common.Address) (*big.Int, error) {
	return _Main.Contract.BalanceOf(&_Main.CallOpts, account)
}

// Earned is a free data retrieval call binding the contract method 0x008cc262.
//
// Solidity: function earned(address account) view returns(uint256)
func (_Main *MainCaller) Earned(opts *bind.CallOpts, account common.Address) (*big.Int, error) {
	var out []interface{}
	err := _Main.contract.Call(opts, &out, "earned", account)

	if err != nil {
		return *new(*big.Int), err
	}

	out0 := *abi.ConvertType(out[0], new(*big.Int)).(**big.Int)

	return out0, err

}

// Earned is a free data retrieval call binding the contract method 0x008cc262.
//
// Solidity: function earned(address account) view returns(uint256)
func (_Main *MainSession) Earned(account common.Address) (*big.Int, error) {
	return _Main.Contract.Earned(&_Main.CallOpts, account)
}

// Earned is a free data retrieval call binding the contract method 0x008cc262.
//
// Solidity: function earned(address account) view returns(uint256)
func (_Main *MainCallerSession) Earned(account common.Address) (*big.Int, error) {
	return _Main.Contract.Earned(&_Main.CallOpts, account)
}

// GetRewardForDuration is a free data retrieval call binding the contract method 0x1c1f78eb.
//
// Solidity: function getRewardForDuration() view returns(uint256)
func (_Main *MainCaller) GetRewardForDuration(opts *bind.CallOpts) (*big.Int, error) {
	var out []interface{}
	err := _Main.contract.Call(opts, &out, "getRewardForDuration")

	if err != nil {
		return *new(*big.Int), err
	}

	out0 := *abi.ConvertType(out[0], new(*big.Int)).(**big.Int)

	return out0, err

}

// GetRewardForDuration is a free data retrieval call binding the contract method 0x1c1f78eb.
//
// Solidity: function getRewardForDuration() view returns(uint256)
func (_Main *MainSession) GetRewardForDuration() (*big.Int, error) {
	return _Main.Contract.GetRewardForDuration(&_Main.CallOpts)
}

// GetRewardForDuration is a free data retrieval call binding the contract method 0x1c1f78eb.
//
// Solidity: function getRewardForDuration() view returns(uint256)
func (_Main *MainCallerSession) GetRewardForDuration() (*big.Int, error) {
	return _Main.Contract.GetRewardForDuration(&_Main.CallOpts)
}

// LastTimeRewardApplicable is a free data retrieval call binding the contract method 0x80faa57d.
//
// Solidity: function lastTimeRewardApplicable() view returns(uint256)
func (_Main *MainCaller) LastTimeRewardApplicable(opts *bind.CallOpts) (*big.Int, error) {
	var out []interface{}
	err := _Main.contract.Call(opts, &out, "lastTimeRewardApplicable")

	if err != nil {
		return *new(*big.Int), err
	}

	out0 := *abi.ConvertType(out[0], new(*big.Int)).(**big.Int)

	return out0, err

}

// LastTimeRewardApplicable is a free data retrieval call binding the contract method 0x80faa57d.
//
// Solidity: function lastTimeRewardApplicable() view returns(uint256)
func (_Main *MainSession) LastTimeRewardApplicable() (*big.Int, error) {
	return _Main.Contract.LastTimeRewardApplicable(&_Main.CallOpts)
}

// LastTimeRewardApplicable is a free data retrieval call binding the contract method 0x80faa57d.
//
// Solidity: function lastTimeRewardApplicable() view returns(uint256)
func (_Main *MainCallerSession) LastTimeRewardApplicable() (*big.Int, error) {
	return _Main.Contract.LastTimeRewardApplicable(&_Main.CallOpts)
}

// LastUpdateTime is a free data retrieval call binding the contract method 0xc8f33c91.
//
// Solidity: function lastUpdateTime() view returns(uint256)
func (_Main *MainCaller) LastUpdateTime(opts *bind.CallOpts) (*big.Int, error) {
	var out []interface{}
	err := _Main.contract.Call(opts, &out, "lastUpdateTime")

	if err != nil {
		return *new(*big.Int), err
	}

	out0 := *abi.ConvertType(out[0], new(*big.Int)).(**big.Int)

	return out0, err

}

// LastUpdateTime is a free data retrieval call binding the contract method 0xc8f33c91.
//
// Solidity: function lastUpdateTime() view returns(uint256)
func (_Main *MainSession) LastUpdateTime() (*big.Int, error) {
	return _Main.Contract.LastUpdateTime(&_Main.CallOpts)
}

// LastUpdateTime is a free data retrieval call binding the contract method 0xc8f33c91.
//
// Solidity: function lastUpdateTime() view returns(uint256)
func (_Main *MainCallerSession) LastUpdateTime() (*big.Int, error) {
	return _Main.Contract.LastUpdateTime(&_Main.CallOpts)
}

// Owner is a free data retrieval call binding the contract method 0x8da5cb5b.
//
// Solidity: function owner() view returns(address)
func (_Main *MainCaller) Owner(opts *bind.CallOpts) (common.Address, error) {
	var out []interface{}
	err := _Main.contract.Call(opts, &out, "owner")

	if err != nil {
		return *new(common.Address), err
	}

	out0 := *abi.ConvertType(out[0], new(common.Address)).(*common.Address)

	return out0, err

}

// Owner is a free data retrieval call binding the contract method 0x8da5cb5b.
//
// Solidity: function owner() view returns(address)
func (_Main *MainSession) Owner() (common.Address, error) {
	return _Main.Contract.Owner(&_Main.CallOpts)
}

// Owner is a free data retrieval call binding the contract method 0x8da5cb5b.
//
// Solidity: function owner() view returns(address)
func (_Main *MainCallerSession) Owner() (common.Address, error) {
	return _Main.Contract.Owner(&_Main.CallOpts)
}

// PeriodFinish is a free data retrieval call binding the contract method 0xebe2b12b.
//
// Solidity: function periodFinish() view returns(uint256)
func (_Main *MainCaller) PeriodFinish(opts *bind.CallOpts) (*big.Int, error) {
	var out []interface{}
	err := _Main.contract.Call(opts, &out, "periodFinish")

	if err != nil {
		return *new(*big.Int), err
	}

	out0 := *abi.ConvertType(out[0], new(*big.Int)).(**big.Int)

	return out0, err

}

// PeriodFinish is a free data retrieval call binding the contract method 0xebe2b12b.
//
// Solidity: function periodFinish() view returns(uint256)
func (_Main *MainSession) PeriodFinish() (*big.Int, error) {
	return _Main.Contract.PeriodFinish(&_Main.CallOpts)
}

// PeriodFinish is a free data retrieval call binding the contract method 0xebe2b12b.
//
// Solidity: function periodFinish() view returns(uint256)
func (_Main *MainCallerSession) PeriodFinish() (*big.Int, error) {
	return _Main.Contract.PeriodFinish(&_Main.CallOpts)
}

// RewardPerToken is a free data retrieval call binding the contract method 0xcd3daf9d.
//
// Solidity: function rewardPerToken() view returns(uint256)
func (_Main *MainCaller) RewardPerToken(opts *bind.CallOpts) (*big.Int, error) {
	var out []interface{}
	err := _Main.contract.Call(opts, &out, "rewardPerToken")

	if err != nil {
		return *new(*big.Int), err
	}

	out0 := *abi.ConvertType(out[0], new(*big.Int)).(**big.Int)

	return out0, err

}

// RewardPerToken is a free data retrieval call binding the contract method 0xcd3daf9d.
//
// Solidity: function rewardPerToken() view returns(uint256)
func (_Main *MainSession) RewardPerToken() (*big.Int, error) {
	return _Main.Contract.RewardPerToken(&_Main.CallOpts)
}

// RewardPerToken is a free data retrieval call binding the contract method 0xcd3daf9d.
//
// Solidity: function rewardPerToken() view returns(uint256)
func (_Main *MainCallerSession) RewardPerToken() (*big.Int, error) {
	return _Main.Contract.RewardPerToken(&_Main.CallOpts)
}

// RewardPerTokenStored is a free data retrieval call binding the contract method 0xdf136d65.
//
// Solidity: function rewardPerTokenStored() view returns(uint256)
func (_Main *MainCaller) RewardPerTokenStored(opts *bind.CallOpts) (*big.Int, error) {
	var out []interface{}
	err := _Main.contract.Call(opts, &out, "rewardPerTokenStored")

	if err != nil {
		return *new(*big.Int), err
	}

	out0 := *abi.ConvertType(out[0], new(*big.Int)).(**big.Int)

	return out0, err

}

// RewardPerTokenStored is a free data retrieval call binding the contract method 0xdf136d65.
//
// Solidity: function rewardPerTokenStored() view returns(uint256)
func (_Main *MainSession) RewardPerTokenStored() (*big.Int, error) {
	return _Main.Contract.RewardPerTokenStored(&_Main.CallOpts)
}

// RewardPerTokenStored is a free data retrieval call binding the contract method 0xdf136d65.
//
// Solidity: function rewardPerTokenStored() view returns(uint256)
func (_Main *MainCallerSession) RewardPerTokenStored() (*big.Int, error) {
	return _Main.Contract.RewardPerTokenStored(&_Main.CallOpts)
}

// RewardRate is a free data retrieval call binding the contract method 0x7b0a47ee.
//
// Solidity: function rewardRate() view returns(uint256)
func (_Main *MainCaller) RewardRate(opts *bind.CallOpts) (*big.Int, error) {
	var out []interface{}
	err := _Main.contract.Call(opts, &out, "rewardRate")

	if err != nil {
		return *new(*big.Int), err
	}

	out0 := *abi.ConvertType(out[0], new(*big.Int)).(**big.Int)

	return out0, err

}

// RewardRate is a free data retrieval call binding the contract method 0x7b0a47ee.
//
// Solidity: function rewardRate() view returns(uint256)
func (_Main *MainSession) RewardRate() (*big.Int, error) {
	return _Main.Contract.RewardRate(&_Main.CallOpts)
}

// RewardRate is a free data retrieval call binding the contract method 0x7b0a47ee.
//
// Solidity: function rewardRate() view returns(uint256)
func (_Main *MainCallerSession) RewardRate() (*big.Int, error) {
	return _Main.Contract.RewardRate(&_Main.CallOpts)
}

// Rewards is a free data retrieval call binding the contract method 0x0700037d.
//
// Solidity: function rewards(address ) view returns(uint256)
func (_Main *MainCaller) Rewards(opts *bind.CallOpts, arg0 common.Address) (*big.Int, error) {
	var out []interface{}
	err := _Main.contract.Call(opts, &out, "rewards", arg0)

	if err != nil {
		return *new(*big.Int), err
	}

	out0 := *abi.ConvertType(out[0], new(*big.Int)).(**big.Int)

	return out0, err

}

// Rewards is a free data retrieval call binding the contract method 0x0700037d.
//
// Solidity: function rewards(address ) view returns(uint256)
func (_Main *MainSession) Rewards(arg0 common.Address) (*big.Int, error) {
	return _Main.Contract.Rewards(&_Main.CallOpts, arg0)
}

// Rewards is a free data retrieval call binding the contract method 0x0700037d.
//
// Solidity: function rewards(address ) view returns(uint256)
func (_Main *MainCallerSession) Rewards(arg0 common.Address) (*big.Int, error) {
	return _Main.Contract.Rewards(&_Main.CallOpts, arg0)
}

// RewardsDuration is a free data retrieval call binding the contract method 0x386a9525.
//
// Solidity: function rewardsDuration() view returns(uint256)
func (_Main *MainCaller) RewardsDuration(opts *bind.CallOpts) (*big.Int, error) {
	var out []interface{}
	err := _Main.contract.Call(opts, &out, "rewardsDuration")

	if err != nil {
		return *new(*big.Int), err
	}

	out0 := *abi.ConvertType(out[0], new(*big.Int)).(**big.Int)

	return out0, err

}

// RewardsDuration is a free data retrieval call binding the contract method 0x386a9525.
//
// Solidity: function rewardsDuration() view returns(uint256)
func (_Main *MainSession) RewardsDuration() (*big.Int, error) {
	return _Main.Contract.RewardsDuration(&_Main.CallOpts)
}

// RewardsDuration is a free data retrieval call binding the contract method 0x386a9525.
//
// Solidity: function rewardsDuration() view returns(uint256)
func (_Main *MainCallerSession) RewardsDuration() (*big.Int, error) {
	return _Main.Contract.RewardsDuration(&_Main.CallOpts)
}

// RewardsToken is a free data retrieval call binding the contract method 0xd1af0c7d.
//
// Solidity: function rewardsToken() view returns(address)
func (_Main *MainCaller) RewardsToken(opts *bind.CallOpts) (common.Address, error) {
	var out []interface{}
	err := _Main.contract.Call(opts, &out, "rewardsToken")

	if err != nil {
		return *new(common.Address), err
	}

	out0 := *abi.ConvertType(out[0], new(common.Address)).(*common.Address)

	return out0, err

}

// RewardsToken is a free data retrieval call binding the contract method 0xd1af0c7d.
//
// Solidity: function rewardsToken() view returns(address)
func (_Main *MainSession) RewardsToken() (common.Address, error) {
	return _Main.Contract.RewardsToken(&_Main.CallOpts)
}

// RewardsToken is a free data retrieval call binding the contract method 0xd1af0c7d.
//
// Solidity: function rewardsToken() view returns(address)
func (_Main *MainCallerSession) RewardsToken() (common.Address, error) {
	return _Main.Contract.RewardsToken(&_Main.CallOpts)
}

// StakingToken is a free data retrieval call binding the contract method 0x72f702f3.
//
// Solidity: function stakingToken() view returns(address)
func (_Main *MainCaller) StakingToken(opts *bind.CallOpts) (common.Address, error) {
	var out []interface{}
	err := _Main.contract.Call(opts, &out, "stakingToken")

	if err != nil {
		return *new(common.Address), err
	}

	out0 := *abi.ConvertType(out[0], new(common.Address)).(*common.Address)

	return out0, err

}

// StakingToken is a free data retrieval call binding the contract method 0x72f702f3.
//
// Solidity: function stakingToken() view returns(address)
func (_Main *MainSession) StakingToken() (common.Address, error) {
	return _Main.Contract.StakingToken(&_Main.CallOpts)
}

// StakingToken is a free data retrieval call binding the contract method 0x72f702f3.
//
// Solidity: function stakingToken() view returns(address)
func (_Main *MainCallerSession) StakingToken() (common.Address, error) {
	return _Main.Contract.StakingToken(&_Main.CallOpts)
}

// TotalRewardAdded is a free data retrieval call binding the contract method 0x098b8858.
//
// Solidity: function totalRewardAdded() view returns(uint256)
func (_Main *MainCaller) TotalRewardAdded(opts *bind.CallOpts) (*big.Int, error) {
	var out []interface{}
	err := _Main.contract.Call(opts, &out, "totalRewardAdded")

	if err != nil {
		return *new(*big.Int), err
	}

	out0 := *abi.ConvertType(out[0], new(*big.Int)).(**big.Int)

	return out0, err

}

// TotalRewardAdded is a free data retrieval call binding the contract method 0x098b8858.
//
// Solidity: function totalRewardAdded() view returns(uint256)
func (_Main *MainSession) TotalRewardAdded() (*big.Int, error) {
	return _Main.Contract.TotalRewardAdded(&_Main.CallOpts)
}

// TotalRewardAdded is a free data retrieval call binding the contract method 0x098b8858.
//
// Solidity: function totalRewardAdded() view returns(uint256)
func (_Main *MainCallerSession) TotalRewardAdded() (*big.Int, error) {
	return _Main.Contract.TotalRewardAdded(&_Main.CallOpts)
}

// TotalStaked is a free data retrieval call binding the contract method 0x817b1cd2.
//
// Solidity: function totalStaked() view returns(uint256)
func (_Main *MainCaller) TotalStaked(opts *bind.CallOpts) (*big.Int, error) {
	var out []interface{}
	err := _Main.contract.Call(opts, &out, "totalStaked")

	if err != nil {
		return *new(*big.Int), err
	}

	out0 := *abi.ConvertType(out[0], new(*big.Int)).(**big.Int)

	return out0, err

}

// TotalStaked is a free data retrieval call binding the contract method 0x817b1cd2.
//
// Solidity: function totalStaked() view returns(uint256)
func (_Main *MainSession) TotalStaked() (*big.Int, error) {
	return _Main.Contract.TotalStaked(&_Main.CallOpts)
}

// TotalStaked is a free data retrieval call binding the contract method 0x817b1cd2.
//
// Solidity: function totalStaked() view returns(uint256)
func (_Main *MainCallerSession) TotalStaked() (*big.Int, error) {
	return _Main.Contract.TotalStaked(&_Main.CallOpts)
}

// Unstakable is a free data retrieval call binding the contract method 0x9ff4bf16.
//
// Solidity: function unstakable(address account) view returns(bool)
func (_Main *MainCaller) Unstakable(opts *bind.CallOpts, account common.Address) (bool, error) {
	var out []interface{}
	err := _Main.contract.Call(opts, &out, "unstakable", account)

	if err != nil {
		return *new(bool), err
	}

	out0 := *abi.ConvertType(out[0], new(bool)).(*bool)

	return out0, err

}

// Unstakable is a free data retrieval call binding the contract method 0x9ff4bf16.
//
// Solidity: function unstakable(address account) view returns(bool)
func (_Main *MainSession) Unstakable(account common.Address) (bool, error) {
	return _Main.Contract.Unstakable(&_Main.CallOpts, account)
}

// Unstakable is a free data retrieval call binding the contract method 0x9ff4bf16.
//
// Solidity: function unstakable(address account) view returns(bool)
func (_Main *MainCallerSession) Unstakable(account common.Address) (bool, error) {
	return _Main.Contract.Unstakable(&_Main.CallOpts, account)
}

// UserRewardPerTokenPaid is a free data retrieval call binding the contract method 0x8b876347.
//
// Solidity: function userRewardPerTokenPaid(address ) view returns(uint256)
func (_Main *MainCaller) UserRewardPerTokenPaid(opts *bind.CallOpts, arg0 common.Address) (*big.Int, error) {
	var out []interface{}
	err := _Main.contract.Call(opts, &out, "userRewardPerTokenPaid", arg0)

	if err != nil {
		return *new(*big.Int), err
	}

	out0 := *abi.ConvertType(out[0], new(*big.Int)).(**big.Int)

	return out0, err

}

// UserRewardPerTokenPaid is a free data retrieval call binding the contract method 0x8b876347.
//
// Solidity: function userRewardPerTokenPaid(address ) view returns(uint256)
func (_Main *MainSession) UserRewardPerTokenPaid(arg0 common.Address) (*big.Int, error) {
	return _Main.Contract.UserRewardPerTokenPaid(&_Main.CallOpts, arg0)
}

// UserRewardPerTokenPaid is a free data retrieval call binding the contract method 0x8b876347.
//
// Solidity: function userRewardPerTokenPaid(address ) view returns(uint256)
func (_Main *MainCallerSession) UserRewardPerTokenPaid(arg0 common.Address) (*big.Int, error) {
	return _Main.Contract.UserRewardPerTokenPaid(&_Main.CallOpts, arg0)
}

// Exit is a paid mutator transaction binding the contract method 0xe9fad8ee.
//
// Solidity: function exit() returns()
func (_Main *MainTransactor) Exit(opts *bind.TransactOpts) (*types.Transaction, error) {
	return _Main.contract.Transact(opts, "exit")
}

// Exit is a paid mutator transaction binding the contract method 0xe9fad8ee.
//
// Solidity: function exit() returns()
func (_Main *MainSession) Exit() (*types.Transaction, error) {
	return _Main.Contract.Exit(&_Main.TransactOpts)
}

// Exit is a paid mutator transaction binding the contract method 0xe9fad8ee.
//
// Solidity: function exit() returns()
func (_Main *MainTransactorSession) Exit() (*types.Transaction, error) {
	return _Main.Contract.Exit(&_Main.TransactOpts)
}

// GetReward is a paid mutator transaction binding the contract method 0x3d18b912.
//
// Solidity: function getReward() returns()
func (_Main *MainTransactor) GetReward(opts *bind.TransactOpts) (*types.Transaction, error) {
	return _Main.contract.Transact(opts, "getReward")
}

// GetReward is a paid mutator transaction binding the contract method 0x3d18b912.
//
// Solidity: function getReward() returns()
func (_Main *MainSession) GetReward() (*types.Transaction, error) {
	return _Main.Contract.GetReward(&_Main.TransactOpts)
}

// GetReward is a paid mutator transaction binding the contract method 0x3d18b912.
//
// Solidity: function getReward() returns()
func (_Main *MainTransactorSession) GetReward() (*types.Transaction, error) {
	return _Main.Contract.GetReward(&_Main.TransactOpts)
}

// NotifyRewardAmount is a paid mutator transaction binding the contract method 0x3c6b16ab.
//
// Solidity: function notifyRewardAmount(uint256 reward) returns()
func (_Main *MainTransactor) NotifyRewardAmount(opts *bind.TransactOpts, reward *big.Int) (*types.Transaction, error) {
	return _Main.contract.Transact(opts, "notifyRewardAmount", reward)
}

// NotifyRewardAmount is a paid mutator transaction binding the contract method 0x3c6b16ab.
//
// Solidity: function notifyRewardAmount(uint256 reward) returns()
func (_Main *MainSession) NotifyRewardAmount(reward *big.Int) (*types.Transaction, error) {
	return _Main.Contract.NotifyRewardAmount(&_Main.TransactOpts, reward)
}

// NotifyRewardAmount is a paid mutator transaction binding the contract method 0x3c6b16ab.
//
// Solidity: function notifyRewardAmount(uint256 reward) returns()
func (_Main *MainTransactorSession) NotifyRewardAmount(reward *big.Int) (*types.Transaction, error) {
	return _Main.Contract.NotifyRewardAmount(&_Main.TransactOpts, reward)
}

// RecoverERC20 is a paid mutator transaction binding the contract method 0x8980f11f.
//
// Solidity: function recoverERC20(address tokenAddress, uint256 tokenAmount) returns()
func (_Main *MainTransactor) RecoverERC20(opts *bind.TransactOpts, tokenAddress common.Address, tokenAmount *big.Int) (*types.Transaction, error) {
	return _Main.contract.Transact(opts, "recoverERC20", tokenAddress, tokenAmount)
}

// RecoverERC20 is a paid mutator transaction binding the contract method 0x8980f11f.
//
// Solidity: function recoverERC20(address tokenAddress, uint256 tokenAmount) returns()
func (_Main *MainSession) RecoverERC20(tokenAddress common.Address, tokenAmount *big.Int) (*types.Transaction, error) {
	return _Main.Contract.RecoverERC20(&_Main.TransactOpts, tokenAddress, tokenAmount)
}

// RecoverERC20 is a paid mutator transaction binding the contract method 0x8980f11f.
//
// Solidity: function recoverERC20(address tokenAddress, uint256 tokenAmount) returns()
func (_Main *MainTransactorSession) RecoverERC20(tokenAddress common.Address, tokenAmount *big.Int) (*types.Transaction, error) {
	return _Main.Contract.RecoverERC20(&_Main.TransactOpts, tokenAddress, tokenAmount)
}

// RenounceOwnership is a paid mutator transaction binding the contract method 0x715018a6.
//
// Solidity: function renounceOwnership() returns()
func (_Main *MainTransactor) RenounceOwnership(opts *bind.TransactOpts) (*types.Transaction, error) {
	return _Main.contract.Transact(opts, "renounceOwnership")
}

// RenounceOwnership is a paid mutator transaction binding the contract method 0x715018a6.
//
// Solidity: function renounceOwnership() returns()
func (_Main *MainSession) RenounceOwnership() (*types.Transaction, error) {
	return _Main.Contract.RenounceOwnership(&_Main.TransactOpts)
}

// RenounceOwnership is a paid mutator transaction binding the contract method 0x715018a6.
//
// Solidity: function renounceOwnership() returns()
func (_Main *MainTransactorSession) RenounceOwnership() (*types.Transaction, error) {
	return _Main.Contract.RenounceOwnership(&_Main.TransactOpts)
}

// SetRewardsDuration is a paid mutator transaction binding the contract method 0xcc1a378f.
//
// Solidity: function setRewardsDuration(uint256 _rewardsDuration) returns()
func (_Main *MainTransactor) SetRewardsDuration(opts *bind.TransactOpts, _rewardsDuration *big.Int) (*types.Transaction, error) {
	return _Main.contract.Transact(opts, "setRewardsDuration", _rewardsDuration)
}

// SetRewardsDuration is a paid mutator transaction binding the contract method 0xcc1a378f.
//
// Solidity: function setRewardsDuration(uint256 _rewardsDuration) returns()
func (_Main *MainSession) SetRewardsDuration(_rewardsDuration *big.Int) (*types.Transaction, error) {
	return _Main.Contract.SetRewardsDuration(&_Main.TransactOpts, _rewardsDuration)
}

// SetRewardsDuration is a paid mutator transaction binding the contract method 0xcc1a378f.
//
// Solidity: function setRewardsDuration(uint256 _rewardsDuration) returns()
func (_Main *MainTransactorSession) SetRewardsDuration(_rewardsDuration *big.Int) (*types.Transaction, error) {
	return _Main.Contract.SetRewardsDuration(&_Main.TransactOpts, _rewardsDuration)
}

// SetUnlockDuration is a paid mutator transaction binding the contract method 0xdd900769.
//
// Solidity: function setUnlockDuration(uint256 _unlockDuration) returns()
func (_Main *MainTransactor) SetUnlockDuration(opts *bind.TransactOpts, _unlockDuration *big.Int) (*types.Transaction, error) {
	return _Main.contract.Transact(opts, "setUnlockDuration", _unlockDuration)
}

// SetUnlockDuration is a paid mutator transaction binding the contract method 0xdd900769.
//
// Solidity: function setUnlockDuration(uint256 _unlockDuration) returns()
func (_Main *MainSession) SetUnlockDuration(_unlockDuration *big.Int) (*types.Transaction, error) {
	return _Main.Contract.SetUnlockDuration(&_Main.TransactOpts, _unlockDuration)
}

// SetUnlockDuration is a paid mutator transaction binding the contract method 0xdd900769.
//
// Solidity: function setUnlockDuration(uint256 _unlockDuration) returns()
func (_Main *MainTransactorSession) SetUnlockDuration(_unlockDuration *big.Int) (*types.Transaction, error) {
	return _Main.Contract.SetUnlockDuration(&_Main.TransactOpts, _unlockDuration)
}

// Stake is a paid mutator transaction binding the contract method 0xa694fc3a.
//
// Solidity: function stake(uint256 amount) returns()
func (_Main *MainTransactor) Stake(opts *bind.TransactOpts, amount *big.Int) (*types.Transaction, error) {
	return _Main.contract.Transact(opts, "stake", amount)
}

// Stake is a paid mutator transaction binding the contract method 0xa694fc3a.
//
// Solidity: function stake(uint256 amount) returns()
func (_Main *MainSession) Stake(amount *big.Int) (*types.Transaction, error) {
	return _Main.Contract.Stake(&_Main.TransactOpts, amount)
}

// Stake is a paid mutator transaction binding the contract method 0xa694fc3a.
//
// Solidity: function stake(uint256 amount) returns()
func (_Main *MainTransactorSession) Stake(amount *big.Int) (*types.Transaction, error) {
	return _Main.Contract.Stake(&_Main.TransactOpts, amount)
}

// TransferOwnership is a paid mutator transaction binding the contract method 0xf2fde38b.
//
// Solidity: function transferOwnership(address newOwner) returns()
func (_Main *MainTransactor) TransferOwnership(opts *bind.TransactOpts, newOwner common.Address) (*types.Transaction, error) {
	return _Main.contract.Transact(opts, "transferOwnership", newOwner)
}

// TransferOwnership is a paid mutator transaction binding the contract method 0xf2fde38b.
//
// Solidity: function transferOwnership(address newOwner) returns()
func (_Main *MainSession) TransferOwnership(newOwner common.Address) (*types.Transaction, error) {
	return _Main.Contract.TransferOwnership(&_Main.TransactOpts, newOwner)
}

// TransferOwnership is a paid mutator transaction binding the contract method 0xf2fde38b.
//
// Solidity: function transferOwnership(address newOwner) returns()
func (_Main *MainTransactorSession) TransferOwnership(newOwner common.Address) (*types.Transaction, error) {
	return _Main.Contract.TransferOwnership(&_Main.TransactOpts, newOwner)
}

// Unstake is a paid mutator transaction binding the contract method 0x2e17de78.
//
// Solidity: function unstake(uint256 amount) returns()
func (_Main *MainTransactor) Unstake(opts *bind.TransactOpts, amount *big.Int) (*types.Transaction, error) {
	return _Main.contract.Transact(opts, "unstake", amount)
}

// Unstake is a paid mutator transaction binding the contract method 0x2e17de78.
//
// Solidity: function unstake(uint256 amount) returns()
func (_Main *MainSession) Unstake(amount *big.Int) (*types.Transaction, error) {
	return _Main.Contract.Unstake(&_Main.TransactOpts, amount)
}

// Unstake is a paid mutator transaction binding the contract method 0x2e17de78.
//
// Solidity: function unstake(uint256 amount) returns()
func (_Main *MainTransactorSession) Unstake(amount *big.Int) (*types.Transaction, error) {
	return _Main.Contract.Unstake(&_Main.TransactOpts, amount)
}

// MainOwnershipTransferredIterator is returned from FilterOwnershipTransferred and is used to iterate over the raw logs and unpacked data for OwnershipTransferred events raised by the Main contract.
type MainOwnershipTransferredIterator struct {
	Event *MainOwnershipTransferred // Event containing the contract specifics and raw log

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
func (it *MainOwnershipTransferredIterator) Next() bool {
	// If the iterator failed, stop iterating
	if it.fail != nil {
		return false
	}
	// If the iterator completed, deliver directly whatever's available
	if it.done {
		select {
		case log := <-it.logs:
			it.Event = new(MainOwnershipTransferred)
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
		it.Event = new(MainOwnershipTransferred)
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
func (it *MainOwnershipTransferredIterator) Error() error {
	return it.fail
}

// Close terminates the iteration process, releasing any pending underlying
// resources.
func (it *MainOwnershipTransferredIterator) Close() error {
	it.sub.Unsubscribe()
	return nil
}

// MainOwnershipTransferred represents a OwnershipTransferred event raised by the Main contract.
type MainOwnershipTransferred struct {
	PreviousOwner common.Address
	NewOwner      common.Address
	Raw           types.Log // Blockchain specific contextual infos
}

// FilterOwnershipTransferred is a free log retrieval operation binding the contract event 0x8be0079c531659141344cd1fd0a4f28419497f9722a3daafe3b4186f6b6457e0.
//
// Solidity: event OwnershipTransferred(address indexed previousOwner, address indexed newOwner)
func (_Main *MainFilterer) FilterOwnershipTransferred(opts *bind.FilterOpts, previousOwner []common.Address, newOwner []common.Address) (*MainOwnershipTransferredIterator, error) {

	var previousOwnerRule []interface{}
	for _, previousOwnerItem := range previousOwner {
		previousOwnerRule = append(previousOwnerRule, previousOwnerItem)
	}
	var newOwnerRule []interface{}
	for _, newOwnerItem := range newOwner {
		newOwnerRule = append(newOwnerRule, newOwnerItem)
	}

	logs, sub, err := _Main.contract.FilterLogs(opts, "OwnershipTransferred", previousOwnerRule, newOwnerRule)
	if err != nil {
		return nil, err
	}
	return &MainOwnershipTransferredIterator{contract: _Main.contract, event: "OwnershipTransferred", logs: logs, sub: sub}, nil
}

// WatchOwnershipTransferred is a free log subscription operation binding the contract event 0x8be0079c531659141344cd1fd0a4f28419497f9722a3daafe3b4186f6b6457e0.
//
// Solidity: event OwnershipTransferred(address indexed previousOwner, address indexed newOwner)
func (_Main *MainFilterer) WatchOwnershipTransferred(opts *bind.WatchOpts, sink chan<- *MainOwnershipTransferred, previousOwner []common.Address, newOwner []common.Address) (event.Subscription, error) {

	var previousOwnerRule []interface{}
	for _, previousOwnerItem := range previousOwner {
		previousOwnerRule = append(previousOwnerRule, previousOwnerItem)
	}
	var newOwnerRule []interface{}
	for _, newOwnerItem := range newOwner {
		newOwnerRule = append(newOwnerRule, newOwnerItem)
	}

	logs, sub, err := _Main.contract.WatchLogs(opts, "OwnershipTransferred", previousOwnerRule, newOwnerRule)
	if err != nil {
		return nil, err
	}
	return event.NewSubscription(func(quit <-chan struct{}) error {
		defer sub.Unsubscribe()
		for {
			select {
			case log := <-logs:
				// New log arrived, parse the event and forward to the user
				event := new(MainOwnershipTransferred)
				if err := _Main.contract.UnpackLog(event, "OwnershipTransferred", log); err != nil {
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
func (_Main *MainFilterer) ParseOwnershipTransferred(log types.Log) (*MainOwnershipTransferred, error) {
	event := new(MainOwnershipTransferred)
	if err := _Main.contract.UnpackLog(event, "OwnershipTransferred", log); err != nil {
		return nil, err
	}
	event.Raw = log
	return event, nil
}

// MainRecoveredIterator is returned from FilterRecovered and is used to iterate over the raw logs and unpacked data for Recovered events raised by the Main contract.
type MainRecoveredIterator struct {
	Event *MainRecovered // Event containing the contract specifics and raw log

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
func (it *MainRecoveredIterator) Next() bool {
	// If the iterator failed, stop iterating
	if it.fail != nil {
		return false
	}
	// If the iterator completed, deliver directly whatever's available
	if it.done {
		select {
		case log := <-it.logs:
			it.Event = new(MainRecovered)
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
		it.Event = new(MainRecovered)
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
func (it *MainRecoveredIterator) Error() error {
	return it.fail
}

// Close terminates the iteration process, releasing any pending underlying
// resources.
func (it *MainRecoveredIterator) Close() error {
	it.sub.Unsubscribe()
	return nil
}

// MainRecovered represents a Recovered event raised by the Main contract.
type MainRecovered struct {
	Token  common.Address
	Amount *big.Int
	Raw    types.Log // Blockchain specific contextual infos
}

// FilterRecovered is a free log retrieval operation binding the contract event 0x8c1256b8896378cd5044f80c202f9772b9d77dc85c8a6eb51967210b09bfaa28.
//
// Solidity: event Recovered(address token, uint256 amount)
func (_Main *MainFilterer) FilterRecovered(opts *bind.FilterOpts) (*MainRecoveredIterator, error) {

	logs, sub, err := _Main.contract.FilterLogs(opts, "Recovered")
	if err != nil {
		return nil, err
	}
	return &MainRecoveredIterator{contract: _Main.contract, event: "Recovered", logs: logs, sub: sub}, nil
}

// WatchRecovered is a free log subscription operation binding the contract event 0x8c1256b8896378cd5044f80c202f9772b9d77dc85c8a6eb51967210b09bfaa28.
//
// Solidity: event Recovered(address token, uint256 amount)
func (_Main *MainFilterer) WatchRecovered(opts *bind.WatchOpts, sink chan<- *MainRecovered) (event.Subscription, error) {

	logs, sub, err := _Main.contract.WatchLogs(opts, "Recovered")
	if err != nil {
		return nil, err
	}
	return event.NewSubscription(func(quit <-chan struct{}) error {
		defer sub.Unsubscribe()
		for {
			select {
			case log := <-logs:
				// New log arrived, parse the event and forward to the user
				event := new(MainRecovered)
				if err := _Main.contract.UnpackLog(event, "Recovered", log); err != nil {
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

// ParseRecovered is a log parse operation binding the contract event 0x8c1256b8896378cd5044f80c202f9772b9d77dc85c8a6eb51967210b09bfaa28.
//
// Solidity: event Recovered(address token, uint256 amount)
func (_Main *MainFilterer) ParseRecovered(log types.Log) (*MainRecovered, error) {
	event := new(MainRecovered)
	if err := _Main.contract.UnpackLog(event, "Recovered", log); err != nil {
		return nil, err
	}
	event.Raw = log
	return event, nil
}

// MainRewardAddedIterator is returned from FilterRewardAdded and is used to iterate over the raw logs and unpacked data for RewardAdded events raised by the Main contract.
type MainRewardAddedIterator struct {
	Event *MainRewardAdded // Event containing the contract specifics and raw log

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
func (it *MainRewardAddedIterator) Next() bool {
	// If the iterator failed, stop iterating
	if it.fail != nil {
		return false
	}
	// If the iterator completed, deliver directly whatever's available
	if it.done {
		select {
		case log := <-it.logs:
			it.Event = new(MainRewardAdded)
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
		it.Event = new(MainRewardAdded)
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
func (it *MainRewardAddedIterator) Error() error {
	return it.fail
}

// Close terminates the iteration process, releasing any pending underlying
// resources.
func (it *MainRewardAddedIterator) Close() error {
	it.sub.Unsubscribe()
	return nil
}

// MainRewardAdded represents a RewardAdded event raised by the Main contract.
type MainRewardAdded struct {
	Reward *big.Int
	Raw    types.Log // Blockchain specific contextual infos
}

// FilterRewardAdded is a free log retrieval operation binding the contract event 0xde88a922e0d3b88b24e9623efeb464919c6bf9f66857a65e2bfcf2ce87a9433d.
//
// Solidity: event RewardAdded(uint256 reward)
func (_Main *MainFilterer) FilterRewardAdded(opts *bind.FilterOpts) (*MainRewardAddedIterator, error) {

	logs, sub, err := _Main.contract.FilterLogs(opts, "RewardAdded")
	if err != nil {
		return nil, err
	}
	return &MainRewardAddedIterator{contract: _Main.contract, event: "RewardAdded", logs: logs, sub: sub}, nil
}

// WatchRewardAdded is a free log subscription operation binding the contract event 0xde88a922e0d3b88b24e9623efeb464919c6bf9f66857a65e2bfcf2ce87a9433d.
//
// Solidity: event RewardAdded(uint256 reward)
func (_Main *MainFilterer) WatchRewardAdded(opts *bind.WatchOpts, sink chan<- *MainRewardAdded) (event.Subscription, error) {

	logs, sub, err := _Main.contract.WatchLogs(opts, "RewardAdded")
	if err != nil {
		return nil, err
	}
	return event.NewSubscription(func(quit <-chan struct{}) error {
		defer sub.Unsubscribe()
		for {
			select {
			case log := <-logs:
				// New log arrived, parse the event and forward to the user
				event := new(MainRewardAdded)
				if err := _Main.contract.UnpackLog(event, "RewardAdded", log); err != nil {
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

// ParseRewardAdded is a log parse operation binding the contract event 0xde88a922e0d3b88b24e9623efeb464919c6bf9f66857a65e2bfcf2ce87a9433d.
//
// Solidity: event RewardAdded(uint256 reward)
func (_Main *MainFilterer) ParseRewardAdded(log types.Log) (*MainRewardAdded, error) {
	event := new(MainRewardAdded)
	if err := _Main.contract.UnpackLog(event, "RewardAdded", log); err != nil {
		return nil, err
	}
	event.Raw = log
	return event, nil
}

// MainRewardPaidIterator is returned from FilterRewardPaid and is used to iterate over the raw logs and unpacked data for RewardPaid events raised by the Main contract.
type MainRewardPaidIterator struct {
	Event *MainRewardPaid // Event containing the contract specifics and raw log

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
func (it *MainRewardPaidIterator) Next() bool {
	// If the iterator failed, stop iterating
	if it.fail != nil {
		return false
	}
	// If the iterator completed, deliver directly whatever's available
	if it.done {
		select {
		case log := <-it.logs:
			it.Event = new(MainRewardPaid)
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
		it.Event = new(MainRewardPaid)
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
func (it *MainRewardPaidIterator) Error() error {
	return it.fail
}

// Close terminates the iteration process, releasing any pending underlying
// resources.
func (it *MainRewardPaidIterator) Close() error {
	it.sub.Unsubscribe()
	return nil
}

// MainRewardPaid represents a RewardPaid event raised by the Main contract.
type MainRewardPaid struct {
	User   common.Address
	Reward *big.Int
	Raw    types.Log // Blockchain specific contextual infos
}

// FilterRewardPaid is a free log retrieval operation binding the contract event 0xe2403640ba68fed3a2f88b7557551d1993f84b99bb10ff833f0cf8db0c5e0486.
//
// Solidity: event RewardPaid(address indexed user, uint256 reward)
func (_Main *MainFilterer) FilterRewardPaid(opts *bind.FilterOpts, user []common.Address) (*MainRewardPaidIterator, error) {

	var userRule []interface{}
	for _, userItem := range user {
		userRule = append(userRule, userItem)
	}

	logs, sub, err := _Main.contract.FilterLogs(opts, "RewardPaid", userRule)
	if err != nil {
		return nil, err
	}
	return &MainRewardPaidIterator{contract: _Main.contract, event: "RewardPaid", logs: logs, sub: sub}, nil
}

// WatchRewardPaid is a free log subscription operation binding the contract event 0xe2403640ba68fed3a2f88b7557551d1993f84b99bb10ff833f0cf8db0c5e0486.
//
// Solidity: event RewardPaid(address indexed user, uint256 reward)
func (_Main *MainFilterer) WatchRewardPaid(opts *bind.WatchOpts, sink chan<- *MainRewardPaid, user []common.Address) (event.Subscription, error) {

	var userRule []interface{}
	for _, userItem := range user {
		userRule = append(userRule, userItem)
	}

	logs, sub, err := _Main.contract.WatchLogs(opts, "RewardPaid", userRule)
	if err != nil {
		return nil, err
	}
	return event.NewSubscription(func(quit <-chan struct{}) error {
		defer sub.Unsubscribe()
		for {
			select {
			case log := <-logs:
				// New log arrived, parse the event and forward to the user
				event := new(MainRewardPaid)
				if err := _Main.contract.UnpackLog(event, "RewardPaid", log); err != nil {
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

// ParseRewardPaid is a log parse operation binding the contract event 0xe2403640ba68fed3a2f88b7557551d1993f84b99bb10ff833f0cf8db0c5e0486.
//
// Solidity: event RewardPaid(address indexed user, uint256 reward)
func (_Main *MainFilterer) ParseRewardPaid(log types.Log) (*MainRewardPaid, error) {
	event := new(MainRewardPaid)
	if err := _Main.contract.UnpackLog(event, "RewardPaid", log); err != nil {
		return nil, err
	}
	event.Raw = log
	return event, nil
}

// MainRewardsDurationUpdatedIterator is returned from FilterRewardsDurationUpdated and is used to iterate over the raw logs and unpacked data for RewardsDurationUpdated events raised by the Main contract.
type MainRewardsDurationUpdatedIterator struct {
	Event *MainRewardsDurationUpdated // Event containing the contract specifics and raw log

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
func (it *MainRewardsDurationUpdatedIterator) Next() bool {
	// If the iterator failed, stop iterating
	if it.fail != nil {
		return false
	}
	// If the iterator completed, deliver directly whatever's available
	if it.done {
		select {
		case log := <-it.logs:
			it.Event = new(MainRewardsDurationUpdated)
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
		it.Event = new(MainRewardsDurationUpdated)
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
func (it *MainRewardsDurationUpdatedIterator) Error() error {
	return it.fail
}

// Close terminates the iteration process, releasing any pending underlying
// resources.
func (it *MainRewardsDurationUpdatedIterator) Close() error {
	it.sub.Unsubscribe()
	return nil
}

// MainRewardsDurationUpdated represents a RewardsDurationUpdated event raised by the Main contract.
type MainRewardsDurationUpdated struct {
	NewDuration *big.Int
	Raw         types.Log // Blockchain specific contextual infos
}

// FilterRewardsDurationUpdated is a free log retrieval operation binding the contract event 0xfb46ca5a5e06d4540d6387b930a7c978bce0db5f449ec6b3f5d07c6e1d44f2d3.
//
// Solidity: event RewardsDurationUpdated(uint256 newDuration)
func (_Main *MainFilterer) FilterRewardsDurationUpdated(opts *bind.FilterOpts) (*MainRewardsDurationUpdatedIterator, error) {

	logs, sub, err := _Main.contract.FilterLogs(opts, "RewardsDurationUpdated")
	if err != nil {
		return nil, err
	}
	return &MainRewardsDurationUpdatedIterator{contract: _Main.contract, event: "RewardsDurationUpdated", logs: logs, sub: sub}, nil
}

// WatchRewardsDurationUpdated is a free log subscription operation binding the contract event 0xfb46ca5a5e06d4540d6387b930a7c978bce0db5f449ec6b3f5d07c6e1d44f2d3.
//
// Solidity: event RewardsDurationUpdated(uint256 newDuration)
func (_Main *MainFilterer) WatchRewardsDurationUpdated(opts *bind.WatchOpts, sink chan<- *MainRewardsDurationUpdated) (event.Subscription, error) {

	logs, sub, err := _Main.contract.WatchLogs(opts, "RewardsDurationUpdated")
	if err != nil {
		return nil, err
	}
	return event.NewSubscription(func(quit <-chan struct{}) error {
		defer sub.Unsubscribe()
		for {
			select {
			case log := <-logs:
				// New log arrived, parse the event and forward to the user
				event := new(MainRewardsDurationUpdated)
				if err := _Main.contract.UnpackLog(event, "RewardsDurationUpdated", log); err != nil {
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

// ParseRewardsDurationUpdated is a log parse operation binding the contract event 0xfb46ca5a5e06d4540d6387b930a7c978bce0db5f449ec6b3f5d07c6e1d44f2d3.
//
// Solidity: event RewardsDurationUpdated(uint256 newDuration)
func (_Main *MainFilterer) ParseRewardsDurationUpdated(log types.Log) (*MainRewardsDurationUpdated, error) {
	event := new(MainRewardsDurationUpdated)
	if err := _Main.contract.UnpackLog(event, "RewardsDurationUpdated", log); err != nil {
		return nil, err
	}
	event.Raw = log
	return event, nil
}

// MainStakedIterator is returned from FilterStaked and is used to iterate over the raw logs and unpacked data for Staked events raised by the Main contract.
type MainStakedIterator struct {
	Event *MainStaked // Event containing the contract specifics and raw log

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
func (it *MainStakedIterator) Next() bool {
	// If the iterator failed, stop iterating
	if it.fail != nil {
		return false
	}
	// If the iterator completed, deliver directly whatever's available
	if it.done {
		select {
		case log := <-it.logs:
			it.Event = new(MainStaked)
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
		it.Event = new(MainStaked)
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
func (it *MainStakedIterator) Error() error {
	return it.fail
}

// Close terminates the iteration process, releasing any pending underlying
// resources.
func (it *MainStakedIterator) Close() error {
	it.sub.Unsubscribe()
	return nil
}

// MainStaked represents a Staked event raised by the Main contract.
type MainStaked struct {
	User   common.Address
	Amount *big.Int
	Raw    types.Log // Blockchain specific contextual infos
}

// FilterStaked is a free log retrieval operation binding the contract event 0x9e71bc8eea02a63969f509818f2dafb9254532904319f9dbda79b67bd34a5f3d.
//
// Solidity: event Staked(address indexed user, uint256 amount)
func (_Main *MainFilterer) FilterStaked(opts *bind.FilterOpts, user []common.Address) (*MainStakedIterator, error) {

	var userRule []interface{}
	for _, userItem := range user {
		userRule = append(userRule, userItem)
	}

	logs, sub, err := _Main.contract.FilterLogs(opts, "Staked", userRule)
	if err != nil {
		return nil, err
	}
	return &MainStakedIterator{contract: _Main.contract, event: "Staked", logs: logs, sub: sub}, nil
}

// WatchStaked is a free log subscription operation binding the contract event 0x9e71bc8eea02a63969f509818f2dafb9254532904319f9dbda79b67bd34a5f3d.
//
// Solidity: event Staked(address indexed user, uint256 amount)
func (_Main *MainFilterer) WatchStaked(opts *bind.WatchOpts, sink chan<- *MainStaked, user []common.Address) (event.Subscription, error) {

	var userRule []interface{}
	for _, userItem := range user {
		userRule = append(userRule, userItem)
	}

	logs, sub, err := _Main.contract.WatchLogs(opts, "Staked", userRule)
	if err != nil {
		return nil, err
	}
	return event.NewSubscription(func(quit <-chan struct{}) error {
		defer sub.Unsubscribe()
		for {
			select {
			case log := <-logs:
				// New log arrived, parse the event and forward to the user
				event := new(MainStaked)
				if err := _Main.contract.UnpackLog(event, "Staked", log); err != nil {
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

// ParseStaked is a log parse operation binding the contract event 0x9e71bc8eea02a63969f509818f2dafb9254532904319f9dbda79b67bd34a5f3d.
//
// Solidity: event Staked(address indexed user, uint256 amount)
func (_Main *MainFilterer) ParseStaked(log types.Log) (*MainStaked, error) {
	event := new(MainStaked)
	if err := _Main.contract.UnpackLog(event, "Staked", log); err != nil {
		return nil, err
	}
	event.Raw = log
	return event, nil
}

// MainUnlockDurationUpdatedIterator is returned from FilterUnlockDurationUpdated and is used to iterate over the raw logs and unpacked data for UnlockDurationUpdated events raised by the Main contract.
type MainUnlockDurationUpdatedIterator struct {
	Event *MainUnlockDurationUpdated // Event containing the contract specifics and raw log

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
func (it *MainUnlockDurationUpdatedIterator) Next() bool {
	// If the iterator failed, stop iterating
	if it.fail != nil {
		return false
	}
	// If the iterator completed, deliver directly whatever's available
	if it.done {
		select {
		case log := <-it.logs:
			it.Event = new(MainUnlockDurationUpdated)
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
		it.Event = new(MainUnlockDurationUpdated)
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
func (it *MainUnlockDurationUpdatedIterator) Error() error {
	return it.fail
}

// Close terminates the iteration process, releasing any pending underlying
// resources.
func (it *MainUnlockDurationUpdatedIterator) Close() error {
	it.sub.Unsubscribe()
	return nil
}

// MainUnlockDurationUpdated represents a UnlockDurationUpdated event raised by the Main contract.
type MainUnlockDurationUpdated struct {
	NewDuration *big.Int
	Raw         types.Log // Blockchain specific contextual infos
}

// FilterUnlockDurationUpdated is a free log retrieval operation binding the contract event 0xbf6423edafc706e6ae214d98c485a52f610ee2f23148b43d546af3f8834c21b3.
//
// Solidity: event UnlockDurationUpdated(uint256 newDuration)
func (_Main *MainFilterer) FilterUnlockDurationUpdated(opts *bind.FilterOpts) (*MainUnlockDurationUpdatedIterator, error) {

	logs, sub, err := _Main.contract.FilterLogs(opts, "UnlockDurationUpdated")
	if err != nil {
		return nil, err
	}
	return &MainUnlockDurationUpdatedIterator{contract: _Main.contract, event: "UnlockDurationUpdated", logs: logs, sub: sub}, nil
}

// WatchUnlockDurationUpdated is a free log subscription operation binding the contract event 0xbf6423edafc706e6ae214d98c485a52f610ee2f23148b43d546af3f8834c21b3.
//
// Solidity: event UnlockDurationUpdated(uint256 newDuration)
func (_Main *MainFilterer) WatchUnlockDurationUpdated(opts *bind.WatchOpts, sink chan<- *MainUnlockDurationUpdated) (event.Subscription, error) {

	logs, sub, err := _Main.contract.WatchLogs(opts, "UnlockDurationUpdated")
	if err != nil {
		return nil, err
	}
	return event.NewSubscription(func(quit <-chan struct{}) error {
		defer sub.Unsubscribe()
		for {
			select {
			case log := <-logs:
				// New log arrived, parse the event and forward to the user
				event := new(MainUnlockDurationUpdated)
				if err := _Main.contract.UnpackLog(event, "UnlockDurationUpdated", log); err != nil {
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

// ParseUnlockDurationUpdated is a log parse operation binding the contract event 0xbf6423edafc706e6ae214d98c485a52f610ee2f23148b43d546af3f8834c21b3.
//
// Solidity: event UnlockDurationUpdated(uint256 newDuration)
func (_Main *MainFilterer) ParseUnlockDurationUpdated(log types.Log) (*MainUnlockDurationUpdated, error) {
	event := new(MainUnlockDurationUpdated)
	if err := _Main.contract.UnpackLog(event, "UnlockDurationUpdated", log); err != nil {
		return nil, err
	}
	event.Raw = log
	return event, nil
}

// MainWithdrawnIterator is returned from FilterWithdrawn and is used to iterate over the raw logs and unpacked data for Withdrawn events raised by the Main contract.
type MainWithdrawnIterator struct {
	Event *MainWithdrawn // Event containing the contract specifics and raw log

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
func (it *MainWithdrawnIterator) Next() bool {
	// If the iterator failed, stop iterating
	if it.fail != nil {
		return false
	}
	// If the iterator completed, deliver directly whatever's available
	if it.done {
		select {
		case log := <-it.logs:
			it.Event = new(MainWithdrawn)
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
		it.Event = new(MainWithdrawn)
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
func (it *MainWithdrawnIterator) Error() error {
	return it.fail
}

// Close terminates the iteration process, releasing any pending underlying
// resources.
func (it *MainWithdrawnIterator) Close() error {
	it.sub.Unsubscribe()
	return nil
}

// MainWithdrawn represents a Withdrawn event raised by the Main contract.
type MainWithdrawn struct {
	User   common.Address
	Amount *big.Int
	Raw    types.Log // Blockchain specific contextual infos
}

// FilterWithdrawn is a free log retrieval operation binding the contract event 0x7084f5476618d8e60b11ef0d7d3f06914655adb8793e28ff7f018d4c76d505d5.
//
// Solidity: event Withdrawn(address indexed user, uint256 amount)
func (_Main *MainFilterer) FilterWithdrawn(opts *bind.FilterOpts, user []common.Address) (*MainWithdrawnIterator, error) {

	var userRule []interface{}
	for _, userItem := range user {
		userRule = append(userRule, userItem)
	}

	logs, sub, err := _Main.contract.FilterLogs(opts, "Withdrawn", userRule)
	if err != nil {
		return nil, err
	}
	return &MainWithdrawnIterator{contract: _Main.contract, event: "Withdrawn", logs: logs, sub: sub}, nil
}

// WatchWithdrawn is a free log subscription operation binding the contract event 0x7084f5476618d8e60b11ef0d7d3f06914655adb8793e28ff7f018d4c76d505d5.
//
// Solidity: event Withdrawn(address indexed user, uint256 amount)
func (_Main *MainFilterer) WatchWithdrawn(opts *bind.WatchOpts, sink chan<- *MainWithdrawn, user []common.Address) (event.Subscription, error) {

	var userRule []interface{}
	for _, userItem := range user {
		userRule = append(userRule, userItem)
	}

	logs, sub, err := _Main.contract.WatchLogs(opts, "Withdrawn", userRule)
	if err != nil {
		return nil, err
	}
	return event.NewSubscription(func(quit <-chan struct{}) error {
		defer sub.Unsubscribe()
		for {
			select {
			case log := <-logs:
				// New log arrived, parse the event and forward to the user
				event := new(MainWithdrawn)
				if err := _Main.contract.UnpackLog(event, "Withdrawn", log); err != nil {
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

// ParseWithdrawn is a log parse operation binding the contract event 0x7084f5476618d8e60b11ef0d7d3f06914655adb8793e28ff7f018d4c76d505d5.
//
// Solidity: event Withdrawn(address indexed user, uint256 amount)
func (_Main *MainFilterer) ParseWithdrawn(log types.Log) (*MainWithdrawn, error) {
	event := new(MainWithdrawn)
	if err := _Main.contract.UnpackLog(event, "Withdrawn", log); err != nil {
		return nil, err
	}
	event.Raw = log
	return event, nil
}
