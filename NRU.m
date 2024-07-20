%xT Train data
%yT Train label
%xt Test data
%yt Test label
    %KNN based risk score computation for urls
function Res = NRU(xT, yT, xt, yt)
    MxT = xT(yT == 1,:);
    BxT = xT(yT == 0,:);
    IdMxT = knnsearch(MxT,xt);% default k =1 
    IdBxT = knnsearch(BxT,xt);
    MD = sqrt(sum(( xt - xT(IdMxT,:)).^2,2));
    BD = sqrt(sum(( xt - xT(IdBxT,:)).^2,2));
    risks = BD ./ MD;
    [V,IX] = sort(risks,'descend'); %sorting all risk score in descending order to find top score apps
    lab =yt(IX);       % finding label of sorted apps
    N = size(xt,1);    % N is the number of all tested apps
    j =0;
    for i=0.01:0.01:1
        topip =  round(N*i);   % finding the number of top i prescent apps
        %sum(lab(1:topip));        % finding the label of top i prescent apps and then counting the number of malware within top 5(by summation of label 1)  
        j = j+1;
        DetMals(j) = sum(lab(1:topip)); 
        AUC(j) = sum(lab(1:topip))/ topip; % finding area under curve for topi
    end
    %plot results
    Res(2:101) = DetMals/size(xt(yt == 1,:),1); 
    Res(1)=0;