function varargout = MainGUI(varargin)
% MAINGUI M-file for MainGUI.fig
%      MAINGUI, by itself, creates a new MAINGUI or raises the existing
%      singleton*.
%
%      HKFCMPARA = MAINGUI returns the handle to a new MAINGUI or the handle to
%      the existing singleton*.
%
%      MAINGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MAINGUI.M with the given input arguments.
%
%      MAINGUI('Property','Value',...) creates a new MAINGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before MainGUI_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to MainGUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Copyright 2002-2003 The MathWorks, Inc.
% Edit the above text to modify the response to help MainGUI
% Last Modified by GUIDE v2.5 10-May-2005 12:20:34

% Author: Genial.Rong@USTC.P.R.C
% Email: JGRong@ustc.edu
% URL:  http://genial.yculblog.com


% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @MainGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @MainGUI_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before MainGUI is made visible.
function MainGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to MainGUI (see VARARGIN)

% Choose default command line output for MainGUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes MainGUI wait for user response (see UIRESUME)
% uiwait(handles.MainFig);

% 日期时间显示
set(handles.timestr,'string',datestr(now,0));
htimer = timer('StartDelay',1,'TimerFcn',...
    'htimestr=findall(0,''tag'',''timestr'');set(htimestr,''string'',datestr(now,0));',...
    'Period',1,'ExecutionMode','fixedSpacing','tag','showtime');
start(htimer);



% --- Outputs from this function are returned to the command line.
function varargout = MainGUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes during object creation, after setting all properties.
function hslider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to hslider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



% --- Executes during object creation, after setting all properties.
function hedit_fname_CreateFcn(hObject, eventdata, handles)
% hObject    handle to hedit_fname (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function hedit_heb_CreateFcn(hObject, eventdata, handles)
% hObject    handle to hedit_heb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function hedit_xuhao_CreateFcn(hObject, eventdata, handles)
% hObject    handle to hedit_xuhao (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function hedit_zhishu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to hedit_zhishu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function hedit_zuixiao_CreateFcn(hObject, eventdata, handles)
% hObject    handle to hedit_zuixiao (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% --- Executes during object creation, after setting all properties.
function hedit_cishu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to hedit_cishu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function hedit_leibie_CreateFcn(hObject, eventdata, handles)
% hObject    handle to hedit_leibie (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% --- Executes during object creation, after setting all properties.
function hmenu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to hmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function hedit_info_CreateFcn(hObject, eventdata, handles)
% hObject    handle to hedit_info (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% --- Executes on slider movement.
function hslider_Callback(hObject, eventdata, handles)
% hObject    handle to hslider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

% 获取滑动条参数
valMin = get(hObject,'Min'); 
valMax = get(hObject,'Max');
val = get(hObject,'Value');

result = get(handles.btnrun,'UserData'); % 获取分割结果

cluster_n = get(handles.hedit_leibie,'UserData');   % 获取聚类数目
eachstep = (valMax - valMin)/(cluster_n-2);  % 每副图对应的滑块步长
npic = round((val-valMin)/eachstep);    % 计算最近的点
% set(hObject,'Value',eachstep*npic+valMin);  % 自动将滑块移动到整点数

% 得到axes该显示的图像的数据
I1 = result{npic+1};
I2 = result{npic+2};


% 更现分类显示的axes
% 对于第一类的轴
axes(handles.h1leiaxes);
imshow(I1,[]);
set(gcf,'NextPlot','add'); % This is to cinquer the bug of imshow
% 对于第二类的轴
axes(handles.h2leiaxes);
imshow(I2,[]);
set(gcf,'NextPlot','add'); % This is to cinquer the bug of imshow

% 更新轴上的说明文字
h1leitxtstr = ['第',num2str(npic+1),'类图像'];
h2leitxtstr = ['第',num2str(npic+2),'类图像'];
set(handles.h1leitxt,'string',h1leitxtstr);
set(handles.h2leitxt,'string',h2leitxtstr);



% --- Executes on button press in btnOpen.
function btnOpen_Callback(hObject, eventdata, handles)
% hObject    handle to btnOpen (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename, pathname] = uigetfile('*.mat', '打开图像数据文件');
if filename~=0
    set(gcf,'Pointer','watch'); % 改变鼠标状态为等待状态
    drawnow;
    set(handles.hedit_fname,'string',filename);
   % fid=fopen([pathname filename],'r');
   % F=fread(fid,'uint8');
   % fclose(fid);
    load([pathname filename]);
    F = II;
    set(hObject,'UserData',F);
    set(handles.hedit_xuhao,'string',num2str(3));
    % 默认显示第2幅图
    I=F(1+181*181*(3-1):181*181*3);
    I=reshape(I,181,181);
    I=imrotate(I,90);
    axes(handles.hyuansiaxes);
    himage = imshow(I,[]);
    set(gcf,'NextPlot','add'); % This is to cinquer the bug of imshow
    % in image toolbox ver 5.0.0 and 5.0.1.
    set(handles.hyuansiaxes,'UserData',I);
    set(gcf,'Pointer','arrow');
    set(handles.hslider,'enable','off'); % 滑动条不可用
    set(handles.btnsave,'enable','off');    % 结果保存按钮不可用 
else
    set(handles.hedit_fname,'string','尚未打开');
end


function hedit_heb_Callback(hObject, eventdata, handles)
% hObject    handle to hedit_heb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'String') returns contents of hedit_heb as text
%        str2double(get(hObject,'String')) returns contents of hedit_heb as a double
str = get(hObject,'string');
data = str2num(str);
if isempty(data)  % 输入参数有效性检测
    errordlg('输入必须为数值！','参数错误');
    set(hObject,'BackgroundColor','r');
else
    set(hObject,'BackgroundColor','w');
    set(hObject,'UserData',data);
end



function hedit_xuhao_Callback(hObject, eventdata, handles)
% hObject    handle to hedit_xuhao (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'String') returns contents of hedit_xuhao as text
%        str2double(get(hObject,'String')) returns contents of hedit_xuhao as a double
str = get(hObject,'string');
data = str2num(str);
if isempty(data)  % 输入参数有效性检测
    errordlg('输入必须为数值！','参数错误');
    set(hObject,'BackgroundColor','r');
elseif data<1 || data>7 || data~=round(data) % 如果序号超出范围，或不是整数
    errordlg('输入必须为介于1到7之间的整数！','参数错误');
    set(hObject,'BackgroundColor','r');
else
    set(hObject,'BackgroundColor','w');
    % 根据输入序号显示原图
    F = get(handles.btnOpen,'UserData');
    if isempty(F)
        msgbox('尚未打开图像数据文件','操作错误');
        return;
    else
        I=F(1+181*181*(data-1):181*181*data);
        I=reshape(I,181,181);
        I=imrotate(I,90);
        axes(handles.hyuansiaxes);
        himage = imshow(I,[]);
        set(gcf,'NextPlot','add'); % This is to cinquer the bug of imshow 
                        % in image toolbox ver 5.0.0 and 5.0.1. 
        set(handles.hyuansiaxes,'UserData',I);
        set(handles.hedit_xuhao,'UserData',data);
    end
end



function hedit_zhishu_Callback(hObject, eventdata, handles)
% hObject    handle to hedit_zhishu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'String') returns contents of hedit_zhishu as text
%        str2double(get(hObject,'String')) returns contents of hedit_zhishu as a double
str = get(hObject,'string');
data = str2num(str);
if isempty(data)  % 输入参数有效性检测
    errordlg('输入必须为数值！','参数错误');
    set(hObject,'BackgroundColor','r');
elseif data<=1 % 如果指数不大于1
    errordlg('输入必须大于1','参数错误');
    set(hObject,'BackgroundColor','r');
else    
    set(hObject,'BackgroundColor','w');
    set(hObject,'UserData',data);
end



function hedit_zuixiao_Callback(hObject, eventdata, handles)
% hObject    handle to hedit_zuixiao (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'String') returns contents of hedit_zuixiao as text
%        str2double(get(hObject,'String')) returns contents of hedit_zuixiao as a double
str = get(hObject,'string');
data = str2num(str);
if isempty(data)  % 输入参数有效性检测
    errordlg('输入必须为数值！','参数错误');
    set(hObject,'BackgroundColor','r');
elseif data<0 % 如果指数不大于1
    errordlg('输入必须大于0','参数错误');
    set(hObject,'BackgroundColor','r');
else    
    set(hObject,'BackgroundColor','w');
    set(hObject,'UserData',data);
end



function hedit_cishu_Callback(hObject, eventdata, handles)
% hObject    handle to hedit_cishu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'String') returns contents of hedit_cishu as text
%        str2double(get(hObject,'String')) returns contents of hedit_cishu as a double
str = get(hObject,'string');
data = str2num(str);
if isempty(data)  % 输入参数有效性检测
    errordlg('输入必须为数值！','参数错误');
    set(hObject,'BackgroundColor','r');
elseif data<1 || data~=round(data) % 如果序号超出范围，或不是整数
    errordlg('输入必须为大于等于1的整数！','参数错误');
    set(hObject,'BackgroundColor','r');
else    
    set(hObject,'BackgroundColor','w');
    set(hObject,'UserData',data);
    
end




function hedit_leibie_Callback(hObject, eventdata, handles)
% hObject    handle to hedit_leibie (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'String') returns contents of hedit_leibie as text
%        str2double(get(hObject,'String')) returns contents of hedit_leibie as a double
str = get(hObject,'string');
data = str2num(str);
if isempty(data)  % 输入参数有效性检测
    errordlg('输入必须为数值！','参数错误');
    set(hObject,'BackgroundColor','r');
elseif data<2 || data~=round(data) % 如果序号超出范围，或不是整数
    errordlg('输入必须为大于等于2的整数！','参数错误');
    set(hObject,'BackgroundColor','r');
else    
    set(hObject,'BackgroundColor','w');
    set(hObject,'UserData',data);    
end


% --- Executes on button press in btnrun.
function btnrun_Callback(hObject, eventdata, handles)
% hObject    handle to btnrun (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% 更改界面控件状态
set(handles.hedit_info,'enable','on');  % 信息输出编辑框可用
set(handles.btnsave,'enable','on');    % 结果保存按钮可用

expo = get(handles.hedit_zhishu,'UserData');    % 指数m
max_iter = get(handles.hedit_cishu,'UserData'); % 最大迭代次数
min_impro = get(handles.hedit_zuixiao,'UserData');  % 目标函数最小改变量
cluster_n = get(handles.hedit_leibie,'UserData');   % 聚类数目
display = get(handles.chkbx,'UserData');    % 每次迭代是否输出信息
algorithm = get(handles.hmenu,'UserData');  % 选择的算法种类

data = get(handles.hyuansiaxes,'UserData'); % 获取原始图像数据
data = data(:);
data_n = size(data, 1); % 求出data的第一维(rows)数,即样本个数
in_n = size(data, 2);   % 求出data的第二维(columns)数，即特征值长度

obj_fcn = zeros(max_iter, 1);	% 初始化输出参数obj_fcn
infostr = '';
if algorithm==1 % FCM图像分割
    U = initfcm(cluster_n, data_n);     % 初始化模糊分配矩阵,使U满足列上相加为1,
    % Main loop  主要循环
    for i = 1:max_iter,
        %在第k步循环中改变聚类中心ceneter,和分配函数U的隶属度值;
        [U, center, obj_fcn(i)] = stepfcm(data, U, cluster_n, expo);
        if display,
            infostr =sprintf([infostr 'FCM:Interate count = %d \n\t obj.fcn = %f\n'],i,obj_fcn(i));
            set(handles.hedit_info,'String',infostr);
            drawnow;
        end
        % 终止条件判别
        if i > 1,
            if abs(obj_fcn(i) - obj_fcn(i-1)) < min_impro,
                break;
            end,
        end
    end
    iter_n = i;	% 实际迭代次数
    obj_fcn(iter_n+1:max_iter) = [];
    if display,
            infostr =sprintf([infostr 'FCM:Actual iterations= %d \n\t obj.fcn = %f\n'],iter_n,obj_fcn(i));
            set(handles.hedit_info,'String',infostr);
            drawnow;
    end       
else    % KFCM图像分割
    kernel_b = get(handles.hedit_heb,'UserData');   % 获取高斯核参数
    U = initkfcm(cluster_n, data_n);	% 初始化模糊分配矩阵,使U满足列上相加为1
    % 初始化聚类中心：从样本数据点中任意选取cluster_n个样本作为聚类中心。当然，
    % 如果采用某些先验知识选取中心或许能够达到加快稳定的效果，但目前不具备这功能
    index = randperm(data_n);   % 对样本序数随机排列
    center_old = data(index(1:cluster_n),:);  % 选取随机排列的序数的前cluster_n个
    % Main loop  主要循环
    for i = 1:max_iter,
        %在第k步循环中改变聚类中心ceneter,和分配函数U的隶属度值;
        [U, center, obj_fcn(i)] = stepkfcm(data,U,center_old, expo, kernel_b);
        if display,
            infostr =sprintf([infostr 'KFCM:Interate count = %d \n\t obj.fcn = %f\n'],i,obj_fcn(i));
            set(handles.hedit_info,'String',infostr);
            drawnow;
        end
        center_old = center;    % 用新的聚类中心代替老的聚类中心
        % 终止条件判别
        if i > 1,
            if abs(obj_fcn(i) - obj_fcn(i-1)) < min_impro, break; end,
        end
    end
    iter_n = i;	% 实际迭代次数
    obj_fcn(iter_n+1:max_iter) = [];
    if display,
        infostr =sprintf([infostr 'KFCM:Actual iterations= %d \n\t obj.fcn = %f\n'],iter_n,obj_fcn(i));
        set(handles.hedit_info,'String',infostr);
        drawnow;
    end
end

% 分割结果显示
maxU = max(U);
data = data';
wholeD = zeros(size(data));
for k = 1:cluster_n
    indexk = (U(k,:) == maxU);
    Ik = indexk.*data;
    Ik = reshape(Ik,181,181);
    result{k} = Ik;
    wholeG(indexk) = k-1;
end   
wholeG = reshape(wholeG,181,181);
result{end+1} = wholeG;
set(handles.btnrun,'UserData',result);

% 显示分割后整体图
axes(handles.hzhengtiaxes);
imshow(wholeG,[]);
set(gcf,'NextPlot','add');

% 显示第一类
axes(handles.h1leiaxes);
imshow(result{1},[]);
set(gcf,'NextPlot','add');

% 显示第二类
axes(handles.h2leiaxes);
imshow(result{2},[]);
set(gcf,'NextPlot','add');

set(handles.hslider,'enable','on'); % 滑动条可用





% --- Executes on button press in btnhelp.
function btnhelp_Callback(hObject, eventdata, handles)
% hObject    handle to btnhelp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



% --- Executes on button press in btnsave.
function btnsave_Callback(hObject, eventdata, handles)
% hObject    handle to btnsave (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

result = get(handles.btnrun,'UserData');

ButtonName=questdlg('保存结果为何种形式?', ...
                       '分割结果保存', ...
                       'JPG图片','MAT文件','MAT文件');
switch ButtonName,
     case 'MAT文件',
         [fname,path] = uiputfile('*.mat','保存为');
         if path==0  % 取消文件保存操作
             return;
         end
         save([path fname],'result','-v6');         
     case 'JPG图片',
         directoryname = uigetdir;
         if directoryname == 0 % canceled
             return;
         end
         pwdir = pwd; % 获得当前目录
         cd(directoryname); % 转到选定目录
         fnametmp = datestr(now,31);
         fnametmp = strrep(fnametmp,':','-');   % 文件名中不能够有:号
         fnametmp = strrep(fnametmp,' ','_');
         for k = 1:length(result)-1
             fnamestr = [fnametmp 'Kind',num2str(k),'.jpg'];
             fcell ={fnamestr};
             tmpM = result{k};
             imwrite(tmpM,fcell{1},'jpg');
         end
         fnamestr = [fnametmp,'Whole.jpg'];
         fcell ={fnamestr};
         tmpM = result{end};
         imwrite(tmpM,fcell{1},'jpg');
         cd(pwdir);
end % switch                   
 



% --- Executes on button press in btnquit.
function btnquit_Callback(hObject, eventdata, handles)
% hObject    handle to btnquit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% selection = questdlg(['退出 ' get(handles.MainFig,'Name') '?'],...
%                      ['退出 ...'],...
%                      '是','否','是');
% if strcmp(selection,'否')
%     return;
% end
htimer = timerfind('tag','showtime');
stop(htimer);
delete(htimer);
delete(handles.MainFig);



% --- Executes on selection change in hmenu.
function hmenu_Callback(hObject, eventdata, handles)
% hObject    handle to hmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns hmenu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from hmenu

val = get(hObject,'Value');
set(hObject,'UserData',val);
if  val == 1
    set(handles.hbtxt,'Visible','off');
    set(handles.hedit_heb,'Visible','off');
elseif val == 2
    set(handles.hbtxt,'Visible','on');
    set(handles.hedit_heb,'Visible','on');
else
    msgbox('不可能出现的吧');
end


% --- Executes on button press in chkbx.
function chkbx_Callback(hObject, eventdata, handles)
% hObject    handle to chkbx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of chkbx

val = get(hObject,'Value');
set(hObject,'UserData',val);
if val==0
    set(handles.hedit_info,'string',{' ';'不输出信息';' '});
else
    set(handles.hedit_info,'string',{' ';'尚未进行分割聚类';' '});
end


% --------------------------------------------------------------------
function hinfosave_Callback(hObject, eventdata, handles)
% hObject    handle to hinfosave (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

infostr = get(handles.hedit_info,'string');
[fname,path] = uiputfile('*.txt','导出为');
if path==0  % 取消文件保存操作
    return;
end
fid = fopen([path fname],'w');
if fid == -1    % 不能够打开文件
    msgbox({'不能打开文件' fname},'文件保存出错','error');
    return;
end

% 保存信息
fprintf(fid,'\r\n=====%s=====\r\n\r\n',datestr(now,31));
for k = 1:size(infostr,1)
    fprintf(fid,'%s',infostr(k,:));
    fprintf(fid,'\r\n');
end
fclose(fid);




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% FCM 需要的子函数

% 子函数
function U = initfcm(cluster_n, data_n)
% 初始化fcm的隶属度函数矩阵
% 输入:
%   cluster_n   ---- 聚类中心个数
%   data_n      ---- 样本点数
% 输出：
%   U           ---- 初始化的隶属度矩阵
U = rand(cluster_n, data_n);
col_sum = sum(U);
U = U./col_sum(ones(cluster_n, 1), :);


% 子函数
function [U_new, center, obj_fcn] = stepfcm(data, U, cluster_n, expo)
% 模糊C均值聚类时迭代的一步
% 输入：
%   data        ---- nxm矩阵,表示n个样本,每个样本具有m的维特征值
%   U           ---- 隶属度矩阵
%   cluster_n   ---- 标量,表示聚合中心数目,即类别数
%   expo        ---- 隶属度矩阵U的指数                      
% 输出：
%   U_new       ---- 迭代计算出的新的隶属度矩阵
%   center      ---- 迭代计算出的新的聚类中心
%   obj_fcn     ---- 目标函数值
mf = U.^expo;       % 隶属度矩阵进行指数运算结果
center = mf*data./((ones(size(data, 2), 1)*sum(mf'))'); % 新聚类中心(5.4)式
dist = distfcm(center, data);       % 计算距离矩阵
obj_fcn = sum(sum((dist.^2).*mf));  % 计算目标函数值 (5.1)式
tmp = dist.^(-2/(expo-1));     
U_new = tmp./(ones(cluster_n, 1)*sum(tmp));  % 计算新的隶属度矩阵 (5.3)式


% 子函数
function out = distfcm(center, data)
% 计算样本点距离聚类中心的距离
% 输入：
%   center     ---- 聚类中心
%   data       ---- 样本点
% 输出：
%   out        ---- 距离
out = zeros(size(center, 1), size(data, 1));
for k = 1:size(center, 1), % 对每一个聚类中心
    % 每一次循环求得所有样本点到一个聚类中心的距离
    out(k, :) = sqrt(sum(((data-ones(size(data,1),1)*center(k,:)).^2)',1));
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% KFCM 需要的子函数

% 子函数
function U = initkfcm(cluster_n, data_n)
% 初始化fcm的隶属度函数矩阵
% 输入:
%   cluster_n   ---- 聚类中心个数
%   data_n      ---- 样本点数
% 输出：
%   U           ---- 初始化的隶属度矩阵
U = rand(cluster_n, data_n);
col_sum = sum(U);
U = U./col_sum(ones(cluster_n, 1), :);


% 子函数
function [U_new,center_new,obj_fcn] = stepkfcm(data,U,center,expo,kernel_b)
% 模糊C均值聚类时迭代的一步
% 输入：
%   data        ---- nxm矩阵,表示n个样本,每个样本具有m的维特征值
%   U           ---- 隶属度矩阵
%   center      ---- 聚类中心
%   expo        ---- 隶属度矩阵U的指数         
%   kernel_b    ---- 高斯核函数的参数
% 输出：
%   U_new       ---- 迭代计算出的新的隶属度矩阵
%   center_new  ---- 迭代计算出的新的聚类中心
%   obj_fcn     ---- 目标函数值
feature_n = size(data,2);  % 特征维数
cluster_n = size(center,1); % 聚类个数
mf = U.^expo;       % 隶属度矩阵进行指数运算（c行n列)

% 计算新的聚类中心;根据(5.15）式
KernelMat = gaussKernel(center,data,kernel_b); % 计算高斯核矩阵(c行n列)
num = mf.*KernelMat * data;   % 式(5.15)的分子(c行p列,p为特征维数)
den = sum(mf.*KernelMat,2);   % 式子(5.15)的分子，(c行,1列,尚未扩展)
center_new = num./(den*ones(1,feature_n)); % 计算新的聚类中心(c行p列,c个中心)

% 计算新的隶属度矩阵；根据(5.14)式子
kdist = distkfcm(center_new, data, kernel_b);    % 计算距离矩阵
obj_fcn = sum(sum((kdist.^2).*mf));  % 计算目标函数值 (5.11)式
tmp = kdist.^(-1/(expo-1));     
U_new = tmp./(ones(cluster_n, 1)*sum(tmp)); 


% 子函数
function out = distkfcm(center, data, kernel_b)
% 计算样本点距离聚类中心的距离
% 输入：
%   center     ---- 聚类中心
%   data       ---- 样本点
% 输出：
%   out        ---- 距离
cluster_n = size(center, 1);
data_n = size(data, 1);
out = zeros(cluster_n, data_n);
for i = 1:cluster_n % 对每个聚类中心 
    vi = center(i,:);
    out(i,:) = 2-2*gaussKernel(vi,data,kernel_b);
end


% 子函数
function out = gaussKernel(center,data,kernel_b)
% 高斯核函数计算
% 输入:
%   center      ---- 模糊聚类中心
%   data        ---- 样本数据点
%   kernel_b    ---- 高斯核参数
% 输出：
%   out         ---- 高斯核计算结果
if nargin == 2
    kernel_b = 150;
end
dist = zeros(size(center, 1), size(data, 1));
for k = 1:size(center, 1), % 对每一个聚类中心
    % 每一次循环求得所有样本点到一个聚类中心的距离
    dist(k, :) = sqrt(sum(((data-ones(size(data,1),1)*center(k,:)).^2)',1));
end
out = exp(-dist.^2/kernel_b^2);



 



