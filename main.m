clear all;
clc;
close all;

%% configurations

% line width
conf_linewidth = 4;

% download file
flag_download_table = false;

%% data

pop.Spain = 46524943;
pop.Brazil = 210147125;
pop.China = 1427647786;
pop.Italy = 60317546;
pop.Argentina = 43590368;
pop.Uk = 67545757;
pop.Us = 328239523;

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
country_us = data.UnitedStates;

% converting nan to 0
total_infections(isnan(total_infections))=0;
country_spain(isnan(country_spain))=0;
country_brazil(isnan(country_brazil))=0;
country_china(isnan(country_china))=0;
country_italy(isnan(country_italy))=0;
country_argentina(isnan(country_argentina))=0;
country_uk(isnan(country_uk))=0;
country_us(isnan(country_us))=0;

% 1st derivative
diff_spain = diff(country_spain);
diff_brazil = diff(country_brazil);
diff_china = diff(country_china);
diff_italy = diff(country_italy);
diff_argentina = diff(country_argentina);
diff_uk = diff(country_uk);
diff_us = diff(country_us);

% 2nd derivative
diff2_spain = diff(diff_spain);
diff2_brazil = diff(diff_brazil);
diff2_china = diff(diff_china);
diff2_italy = diff(diff_italy);
diff2_argentina = diff(diff_argentina);
diff2_uk = diff(diff_uk);
diff2_us = diff(diff_us);

%% plotting

% plotting world absolute
figure;
subplot(2,2,1);
hold on;
grid on;
plot(time_base,country_brazil, 'xg','LineWidth',conf_linewidth);
plot(time_base,country_spain, 'xr','LineWidth',conf_linewidth);
plot(time_base,country_china, 'xk','LineWidth',conf_linewidth);
plot(time_base, country_italy, 'xb', 'LineWidth', conf_linewidth);
plot(time_base, country_us, 'xm', 'LineWidth', conf_linewidth);
plot(time_base,total_infections,'xc', 'LineWidth', conf_linewidth);
legend('Brasil','Espanha','China', 'Italia','US','Total Mundo');
xlabel('Dia'); ylabel('Infectados'); title('Infectados Absoluto');

% plotting normalized infected
subplot(2,2,2);
hold on;
grid on; 
plot(time_base, country_brazil/pop.Brazil, 'xg', 'LineWidth', conf_linewidth);
plot(time_base, country_spain/pop.Spain, 'xr', 'LineWidth', conf_linewidth);
plot(time_base, country_china/pop.China, 'xk', 'LineWidth', conf_linewidth);
plot(time_base, country_italy/pop.Italy, 'xb', 'LineWidth', conf_linewidth);
plot(time_base, country_us/pop.Us, 'xm', 'LineWidth', conf_linewidth);
legend('Brasil','Espanha','China','Italia', 'US');
xlabel('Dia'); ylabel('Infectados'); title('Infectados Normalizado');

% plotting 1st derivative
subplot(2,2,3);
hold on;
grid on; 
time_base_dif = time_base(2:length(time_base));
plot(time_base_dif, diff_brazil, ':g', 'LineWidth', conf_linewidth-2);
plot(time_base_dif, diff_spain, ':r', 'LineWidth', conf_linewidth-2);
plot(time_base_dif, diff_italy, ':b', 'LineWidth', conf_linewidth-2);
plot(time_base_dif, diff_china, ':k', 'LineWidth', conf_linewidth-2);
plot(time_base_dif, diff_us, ':m', 'LineWidth', conf_linewidth-2);
legend('Brasil','Espanha','Italia', 'China', 'US');
xlabel('Dia'); ylabel('Infectados/dia'); title('Infec./dia');

% plotting 1st derivative
subplot(2,2,4);
hold on;
grid on; 
time_base_dif2 = time_base(3:length(time_base));
plot(time_base_dif2, diff2_brazil, ':g', 'LineWidth', conf_linewidth-2);
plot(time_base_dif2, diff2_spain, ':r', 'LineWidth', conf_linewidth-2);
plot(time_base_dif2, diff2_italy, ':b', 'LineWidth', conf_linewidth-2);
plot(time_base_dif2, diff2_china, ':k', 'LineWidth', conf_linewidth-2);
plot(time_base_dif2, diff2_us, ':m', 'LineWidth', conf_linewidth-2);
legend('Brasil','Espanha','Italia', 'China', 'US');
xlabel('Dia'); ylabel('Infectados/dia^2'); title('Infec./dia^2');















