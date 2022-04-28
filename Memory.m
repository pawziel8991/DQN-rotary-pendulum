classdef Memory < handle
    properties
        limit;
        size;
        prestates;
        actions;
        rewards;
        poststates;
        Loss;
    end
    
    methods
        function this = Memory(limit, dims)
        % MEMORY Initialize memory.
        % Parameters:
        %  limit - memory maximum size
        %  dims - dimensions of states, e.g. [4 4]
        % Returns memory object.
        % Memory is kept as five matrices: prestates, actions, rewards,
        % poststates and terminals.

            this.size = 0;
            this.limit = limit;
            this.prestates = zeros([limit dims]);
            this.actions = zeros(limit, 1);
            this.rewards = zeros(limit, 1);
            this.poststates = zeros([limit dims]);
            this.Loss = zeros(limit, 1);
        end

        function add(this, prestate, action, reward, poststate,loss)
        % ADD Add one state transition to memory.
        % Parameters:
        %  m - memory object
        %  prestate - state before (matrix)
        %  action - action taken in this state
        %  reward - observerd reward
        %  poststate - state after the action
        %  terminal - if poststate is terminal state (game over)
        % Returns new memory object.

            % roll over to first if over limit
            this.size = this.size + 1;
            index = mod(this.size - 1, this.limit) + 1;
            % store state transition in memory at position index
            this.prestates(index, :, :) = prestate;
            this.actions(index) = action;
            this.rewards(index) = reward;
            this.poststates(index, :, :) = poststate;
            this.Loss(index) = loss;
        end

        function batch = minibatch(this, minibatch_size)
        % MINIBATCH Return minibatch from memory.
        % Parameters:
        %  m - memory object
        %  minibatch_size - size of the minibatch
        % Returns minibatch struct, containing four matrices: prestates, actions,
        % rewards and poststates.
            suma=0;
            indexes = zeros(minibatch_size, 1);
            % find minibatch_size random indexes of memory
            for probka=(1:(min(this.size, this.limit)))
                suma=suma+this.Loss(probka);
            end
            
            for h=1:minibatch_size                
                random=unifrnd(0, suma);
                sumaprobek=0;
                iter=1;
                while (sumaprobek<random)
                    sumaprobek=sumaprobek+this.Loss(iter);
                    iter=iter+1;
                end
            indexes(h)=iter-1;
            end
                   
%             indexes = randperm(min(this.size, this.limit), minibatch_size);
            % return values of those cells
            batch.prestates = this.prestates(indexes, :, :);
            batch.actions = this.actions(indexes);
            batch.rewards = this.rewards(indexes);
            batch.poststates = this.poststates(indexes, :, :);
            batch.Loss = this.Loss(indexes, :, :);
        end
                function batch = minibatch2(this, minibatch_size)
        % MINIBATCH Return minibatch from memory.
        % Parameters:
        %  m - memory object
        %  minibatch_size - size of the minibatch
        % Returns minibatch struct, containing four matrices: prestates, actions,
        % rewards and poststates.

            % find minibatch_size random indexes of memory
            indexes = randperm(min(this.size, this.limit), minibatch_size);
            % return values of those cells
            batch.prestates = this.prestates(indexes, :, :);
            batch.actions = this.actions(indexes);
            batch.rewards = this.rewards(indexes);
            batch.poststates = this.poststates(indexes, :, :);
        end
                function all = allmemory(this)
        % MINIBATCH Return minibatch from memory.
        % Parameters:
        %  m - memory object
        %  minibatch_size - size of the minibatch
        % Returns minibatch struct, containing four matrices: prestates, actions,
        % rewards and poststates.

            % find minibatch_size random indexes of memory
            indexes = 1:(min(this.size, this.limit));
            % return values of those cells
            all.prestates = this.prestates(indexes, :, :);
            all.actions = this.actions(indexes);
            all.rewards = this.rewards(indexes);
            all.poststates = this.poststates(indexes, :, :);
            all.Loss = this.Loss(indexes, :, :);
        end
    end
end
