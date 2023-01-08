clear
fprintf('\nData Analysis 2022-2023 Fall Project - Marya Aktas 200444001\n\n')
fprintf("The dataset that is used in this code is 'Breast Cancer Coimbra'\n")
fprintf("In this dataset, there are 10 predictors, all quantitative, and a binary dependent variable, " + ...
    "indicating the presence or absence of breast cancer.\nThe predictors are anthropometric " + ...
    "data and parameters which can be gathered in routine blood analysis.\n")
fprintf("In classification attribute, 1 indicates 'Healthy controls' and 2 indicates 'Patients'\n")
importedData=importdata('BreastCancerCoimbra.csv');
DATASET=importedData.data;
HEADER=importedData.textdata;
while true
    fprintf(['\n\n---Menu---\n\n0. Exit the code\n1. Find the centered data matrix\n' ...
        '2. Retrieve some informations on a specific column\n3. Append a new sample data and finding its class\n' ...
        '4. Display the dataset\n5. Interpretation of the skewness and the kurtosis of all attributes\n\n'])
    option=input('Please choose one of the above: ');
    switch option
        case 0
            fprintf('\nExiting from the code...\n')
            break
        case 1
            fprintf('\nThe centered data matrix of the given dataset is:\n')
            Cent_Data=centeredDataMatrix(DATASET);
            disp(Cent_Data)
        case 2
            fprintf(['\n1. Age\n2. BMI\n3. Glucose\n4. Insulin\n5. HOMA\n6. Leptin\n7. Adiponectin\n' ...
                '8. Resistin\n9. MCP.1\n10. Classification\n']);
            str=sprintf('Please choose one specific column(values between 1-%d): ', size(DATASET,2));
            column=input(str);
            if (column<1) | (column>size(DATASET,2))
                disp('Invalid input for column number!')
                continue
            end
            
            while true
                fprintf(['\n\n---Operations---\n0. Return back to beginning page\n' ...
                    '1. Find the mean\n2. Find the median\n3. Find the sum\n4. Find the maximum value\n' ...
                    '5. Find the range\n6. Find the skewness\n7. Find the kurtosis\n8. Display the boxplot\n' ...
                    '9. Find the number of outliers'])
                opt2=input('\nPlease choose one of the above for performing on the specified attribute: ');
                fprintf('\n')
                switch opt2
                    case 0
                        disp('Exiting from the column operations...')
                        break
                    case 1
                        MEAN=mean(DATASET(:,column));
                        fprintf('\nThe mean of the ''%s'' attribute is: %f\n', HEADER{column},MEAN)
                    case 2
                        MEDIAN=prctile(DATASET(:,column),50);
                        fprintf('The median of the ''%s'' attribute is: %f\n', HEADER{column}, MEDIAN)
                    case 3
                        SUM=sum(DATASET(:,column));
                        fprintf('The summation of all object in the ''%s'' attribute is: %f\n', HEADER{column}, SUM)
                    case 4
                        MAX=max(DATASET(:,column));
                        fprintf('The maximum value of the ''%s'' attribute is: %f\n', HEADER{column}, MAX)
                    case 5
                        RANGE=range(DATASET(:,column));
                        fprintf('The range of the ''%s'' attribute is: %f\n', HEADER{column}, RANGE)
                    case 6
                        SKEW=skewness(DATASET(:,column));
                        fprintf('The skewness of the given attribute is: %f\n', SKEW)
                        if SKEW<0
                            fprintf("Most of the peoples' %s is greater than %f", HEADER{column}, mean(DATASET(:,column)))
                        elseif SKEW>0
                            fprintf("Most of the peoples' %s is less than %f", HEADER{column}, mean(DATASET(:,column)))
                        else
                            fprintf("Most of the peoples' %s is around %f", HEADER{column}, mean(DATASET(:,column)))
                        end
                    case 7
                        KURTOSIS=kurtosis(DATASET(:,column));
                        fprintf('The kurtosis of the given attribute is: %f\n', KURTOSIS)
                        if KURTOSIS>3
                            fprintf("Most of the peoples' '%s' is in a small range that is around %f", HEADER{column}, mean(DATASET(:,column)))
                        elseif KURTOSIS<3
                            fprintf("Most of the peoples' '%s' is in a large range that is around %f", HEADER{column}, mean(DATASET(:,column)))
                        else
                            fprintf("Most of the peoples' '%s' is around %f", HEADER{column}, mean(DATASET(:,column)))
                        end
                    case 8
                        fprintf('The boxplot of the ''%s'' attribute is given above...\n', HEADER{column})
                        col=DATASET(:,column);
                        boxplot(col)
                    case 9
                        outCount=outlierCount(DATASET(:,column));
                        fprintf('The number of outliers of the ''%s'' attribute is: %d\n', HEADER{column}, outCount)
                    otherwise
                        fprintf('Unvalid option!\nPlease choose a valid option...\n')
                end
        
        
            end
        case 3
            testTuple=input(['Please enter the values of the predictors of the new person ' ...
                '(as a data vector with size 1x9) to see which class it belongs to: ']);
            CLASSIFICATION=bayesClassifier(DATASET,testTuple);
            fprintf('The predicted category of this person is: %d', CLASSIFICATION)
            if CLASSIFICATION==1
                fprintf('\n... meaning that this person is not a breast cancer patient.\n')
            elseif CLASSIFICATION==2
                fprintf('\n... meaning that this person is a breast cancer patient.\n')
            end    
            testTuple(:,end+1)=CLASSIFICATION;
            DATASET(end+1,:)=testTuple;

            fprintf('\nThe new sample data added to the dataset successfully...\n')
        case 4
            fprintf('This data matrix consist of numeric values with size %dx%d',size(DATASET,1),size(DATASET,2))
            fprintf('\nThe numeric values of displayed dataset is divided by 1.0e+03 \n\n')
            disp(DATASET)
        case 5
            fprintf('\n-SKEWNESS INTERPRETATION-\n')
            for i=1:size(DATASET,2)-1
                fprintf('\nThe skewness value of ''%s'' is: %f\nIndicates that ', HEADER{i}, skewness(DATASET(:,i)))
                if skewness(DATASET(:,i))<0
                    fprintf("most of the peoples' '%s' is greater than %f", HEADER{i}, mean(DATASET(:,i)))
                elseif skewness(DATASET(:,i))>0
                    fprintf("most of the peoples' '%s' is less than %f", HEADER{i}, mean(DATASET(:,i)))
                else
                    fprintf("most of the peoples' '%s' is around %f", HEADER{i}, mean(DATASET(:,i)))
                end
                fprintf('\n')
            end

            fprintf('\n-KURTOSIS INTERPRETATION-\n')
            for i=1:size(DATASET,2)-1
                fprintf('\nThe kurtosis value of ''%s'' is: %f\nIndicates that ', HEADER{i}, kurtosis(DATASET(:,i)))
                if kurtosis(DATASET(:,i))>3
                    fprintf("most of the peoples' '%s' is in a small range that is around %f", HEADER{i}, mean(DATASET(:,i)))
                elseif kurtosis(DATASET(:,i))<3
                    fprintf("most of the peoples' '%s' is in a large range that is around %f", HEADER{i}, mean(DATASET(:,i)))
                else
                    fprintf("most of the peoples' '%s' is around %f", HEADER{i}, mean(DATASET(:,i)))
                end
                fprintf('\n')
            end
        otherwise
            fprintf('\nInvalid option!\nPlease select a valid option!\n')
            continue
    end
end

function out=FX(X, MEAN, E, d)
    mat=X-MEAN;
    inv_E=inv(E);
    firstPart=1/((sqrt(2*pi)^d)*sqrt(det(E)));
    seconfPart=-1*(((mat)*(inv_E)*(mat'))/2);
    out=(firstPart)*exp(seconfPart);
end

function [PROB,MEAN,E]=bayesClassifierHelper(matrix,class)
    rowCountClass=size(class,1);
    rowCountDataset=size(matrix,1);
    PROB=rowCountClass/rowCountDataset;
    MEAN=mean(class);
    centered=centeredDataMatrix(class);
    E=(1/rowCountClass)*(centered')*centered;
end

function CLASSIFICATION=bayesClassifier(matrix, X)
    class1=[];
    class2=[];
    colNumber=size(matrix,2);
    c=colNumber-1;

    for i=1:size(matrix,1)
        if matrix(i,end)==1
            class1(end+1,:)=matrix(i, 1:c);
        elseif matrix(i,end)==2
            class2(end+1,:)=matrix(i, 1:c);
        end     
    end

    [PC1, mean1, E1]=bayesClassifierHelper(matrix,class1);
    [PC2, mean2, E2]=bayesClassifierHelper(matrix,class2);

    PROBS=[];
    
    PROBS(1)=FX(X, mean1, E1, colNumber)*PC1;
    PROBS(2)=FX(X, mean2, E2, colNumber)*PC2;
    

    CLASSIFICATION = find(PROBS==max(PROBS));
    
    
end

function out=centeredDataMatrix(matrix)
    onesMatrix=ones(size(matrix,1),1);
    meanMatrix=mean(matrix);
    out=matrix-onesMatrix*meanMatrix;
end

function out=outlierCount(matrix)
    Q25=prctile(matrix,25);
    Q75=prctile(matrix,75);
    interQ=Q75-Q25;
    LL=Q25-1.5*interQ;
    UL=Q75+1.5*interQ;
    count=0;
    for i = 1:length(matrix)
        if (matrix(i)>UL) | (matrix(i)<LL)
            count=count+1;
        end
    end
    out=count;
end


