clear all;
clc;
close all;

%% configurations

% line width
conf_linewidth = 4;

% download file
flag_download_table = true;

%% running

% updating the table
if flag_download_table
    disp('Updating data table...');
    urlwrite('https://covid.ourworldindata.org/data/ecdc/total_cases.csv','total_cases.csv');
end

% loading table
data = readtable('total_cases.csv');

% obtaining data from table
time_base = data.date;
total_infections = data.World;
country_spain = data.Spain; 
country_brazil = data.Brazil;
country_china = data.China;
country_italy = data.Italy;
country_argentina = data.Argentina;
country_uk = data.UnitedKingdom;

% converting nan to 0
total_infections(isnan(total_infections))=0;
country_spain(isnan(country_spain))=0;
country_brazil(isnan(country_brazil))=0;
country_china(isnan(country_china))=0;
country_italy(isnan(country_italy))=0;
country_argentina(isnan(country_argentina))=0;
country_uk(isnan(country_uk))=0;

% 1st derivative
diff_spain = diff(country_spain);
diff_brazil = diff(country_brazil);
diff_china = diff(country_china);
diff_italy = diff(country_italy);
diff_argentina = diff(country_argentina);
diff_uk = diff(country_uk);

% 2nd derivative
diff2_spain = diff(diff_spain);
diff2_brazil = diff(diff_brazil);
diff2_china = diff(diff_china);
diff2_italy = diff(diff_italy);
diff2_argentina = diff(diff_argentina);
diff2_uk = diff(diff_uk);

%% plotting

% plotting world + Brazil
figure;
subplot(2,2,1);
hold on;
grid on;
plot(time_base,country_brazil, '-.g','LineWidth',conf_linewidth);
plot(time_base,country_spain, '-.r','LineWidth',conf_linewidth);
plot(time_base,country_china, '-.k','LineWidth',conf_linewidth);
plot(time_base,total_infections,'xc', 'LineWidth', conf_linewidth);
legend('Brasil','Espanha','China', 'Total Mundo');
xlabel('Dia'); ylabel('Infectados'); title('Infectados Macro');

% plotting brazil + spain
subplot(2,2,2);
hold on;
grid on; 
plot(time_base, country_brazil, '-.g', 'LineWidth', conf_linewidth);
plot(time_base, country_spain, '-.r', 'LineWidth', conf_linewidth);
plot(time_base, country_italy, '-.b', 'LineWidth', conf_linewidth);
plot(time_base, country_argentina, '-.m', 'LineWidth', conf_linewidth);
plot(time_base, country_uk, '-.c','LineWidth', conf_linewidth);
legend('Brasil','Espanha','Italia', 'Argentina', 'UK');
xlabel('Dia'); ylabel('Infectados'); title('Infectados Local');

% plotting 1st derivative
subplot(2,2,3);
hold on;
grid on; 
time_base_dif = time_base(2:length(time_base));
plot(time_base_dif, diff_brazil, '-.g', 'LineWidth', conf_linewidth-2);
plot(time_base_dif, diff_spain, '-.r', 'LineWidth', conf_linewidth-2);
plot(time_base_dif, diff_italy, '-.b', 'LineWidth', conf_linewidth-2);
plot(time_base_dif, diff_china, '-.k', 'LineWidth', conf_linewidth-2);
plot(time_base_dif, diff_uk, '-.c', 'LineWidth', conf_linewidth-2);
legend('Brasil','Espanha','Italia', 'China', 'UK');
xlabel('Dia'); ylabel('Infectados/dia'); title('Infec./dia');

% plotting 1st derivative
subplot(2,2,4);
hold on;
grid on; 
time_base_dif2 = time_base(3:length(time_base));
plot(time_base_dif2, diff2_brazil, '-.g', 'LineWidth', conf_linewidth-2);
plot(time_base_dif2, diff2_spain, '-.r', 'LineWidth', conf_linewidth-2);
plot(time_base_dif2, diff2_italy, '-.b', 'LineWidth', conf_linewidth-2);
plot(time_base_dif2, diff2_china, '-.k', 'LineWidth', conf_linewidth-2);
plot(time_base_dif2, diff2_uk, '-.c', 'LineWidth', conf_linewidth-2);
legend('Brasil','Espanha','Italia', 'China', 'UK');
xlabel('Dia'); ylabel('Infectados/dia^2'); title('Infec./dia^2');















