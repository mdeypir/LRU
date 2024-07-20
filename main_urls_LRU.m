clear all;
%% Implemented by Mahmood Deypir
load('kaggle.mat');  
%load('OpenINTEL.mat');

Benign =  urls(labels==0,:);
Benign_label = labels(labels==0);
Malwares = urls(labels==1,:);
MalLabeles = labels(labels==1);
rib = randperm(size(Benign,1));
rim = randperm(size(Malwares,1));
foldsizeB = round(size(Benign,1) * 0.1);
foldsizeM = round(size(Malwares,1) * 0.1);
for i =1:10
    tIndexB = rib(1:foldsizeB);
    tIndexM = rim(1:foldsizeM);
    TIndexB = rib(foldsizeB+1:end);
    TIndexM = rim(foldsizeM+1:end);
    xt = [Benign(tIndexB,:);Malwares(tIndexM,:)];
    yt = [Benign_label(tIndexB); MalLabeles(tIndexM)];
    xT = [Benign(TIndexB,:);Malwares(TIndexM,:)];
    yT = [Benign_label(TIndexB); MalLabeles(TIndexM)];
    Res1(i,:) = RSS(xT,yT,xt,yt); %RSS
    Res2(i,:) = IR(xT,yT,xt,yt); %IRS
    Res3(i,:) = ERisk(xT,yT,xt,yt); % ERS
    Res4(i,:) = FRisk(xT,yT,xt,yt); % FRU
    Res5(i,:) = NRU(xT,yT,xt,yt); % NRU
    Res6(i,:) = LRU(xT,yT,xt,yt); % LRU
    rib = circshift(rib,[0,foldsizeB]);
    rim = circshift(rim,[0,foldsizeM]);
end
mRes1 = mean(Res1,1); 
mRes2 = mean(Res2,1);
mRes3 = mean(Res3,1);
mRes4 = mean(Res4,1);
mRes5 = mean(Res5,1);
mRes6 = mean(Res6,1);
x=0:0.01:1;
hold all;
p= plot(x,mRes1(1,:));
set(p,'Color','green','LineWidth',1.4);
xlabel('Warning rate','FontSize',12,'FontName','Times','FontWeight','Normal');
ylabel('Detection Rate','FontSize',12,'FontName','Times','FontWeight','Normal');
p = plot(x,mRes2(1,:));
set(p,'Color','blue','LineWidth',1.4);
p = plot(x,mRes3(1,:));
set(p,'Color','yellow','LineWidth',1.4);
p = plot(x,mRes4(1,:));
set(p,'Color','magenta','LineWidth',1.4);
p = plot(x,mRes5(1,:));
set(p,'Color','red','LineWidth',1.4);
p = plot(x,mRes6(1,:));
set(p,'Color','black','LineWidth',1.4);
hleg= legend('RSS','IRS','ERS','FRU','NRU','LRU');
set(hleg,'Location','East');
box on; 
figure;

AUC_RSS = trapz(x,mRes1);  
AUC_IRS = trapz(x,mRes2);    
AUC_ERS = trapz(x,mRes3);    
AUC_FRU = trapz(x,mRes4);    
AUC_NRU = trapz(x,mRes5);    
AUC_LRU = trapz(x,mRes6);  
str ={'RSS','IRS','ERS','FRU','NRU','LRU'};
YAUC = [AUC_RSS,AUC_IRS,AUC_ERS,AUC_FRU,AUC_NRU,AUC_LRU];
b = bar(YAUC);
xticklabels(str);
ylabel('Detection Rate','FontSize',12,'FontName','Times','FontWeight','Normal');
AVG_RSS = mean(mRes1,2)
AVG_IRS = mean(mRes2,2)
AVG_ERS = mean(mRes3,2)
AVG_FRU = mean(mRes4,2)
AVG_NRU = mean(mRes5,2)
AVG_LRU = mean(mRes6,2)
figure
FN_AVG =[1-AVG_RSS, 1-AVG_IRS, 1-AVG_ERS, 1-AVG_FRU, 1-AVG_NRU,1-AVG_LRU];
b2 = bar(FN_AVG);
xticklabels(str);
b2.FaceColor = 'black';
ylabel('False Positive Rate','FontSize',12,'FontName','Times','FontWeight','Normal');



