classdef BankAccount < handle
    %BANKACCOUNT Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        name
        balance
    end
    
    methods
        function obj =  BankAccount(name,balance)
            obj.name = name;
            obj.balance = balance;
        end
        
        function deposit(obj,amount)
            obj.balance=obj.balance+amount;            
        end
        
        function withdrawl(obj,amount)
            obj.balance =obj.balance-amount;
            
        end
        
        function disp(obj)
            fprintf('Name: %s  Balance $%.2f\n\n',obj.name,obj.balance); 
        end
        
    end
    
end

