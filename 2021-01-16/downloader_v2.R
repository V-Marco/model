# update package if necessary ----
# devtools::install_github("kassandra-ru/kassandr")


# load packages ----
library(docxtractr)
library(kassandr)
library(tidyverse)
library(rio)
library(lubridate)


# set data folder ----
info = Sys.info() # получаем информацию о системе

if (info[1] == "Linux") {
  set_libreoffice_path("/usr/bin/libreoffice")  # ubuntu or macos
  Sys.setenv(LD_LIBRARY_PATH = "/usr/lib/libreoffice/program/") # ubuntu protection against libreglo.so not found
  path = "~/Documents/kassandra/data/raw/"
}

if (info[1] == "Windows") {
  Sys.setenv("TAR" = "internal") # if install_github() fails on Windows OS
  set_libreoffice_path("C:/Program Files/LibreOffice/program/soffice.exe")  # windows
  path = "D:/Research/Kassandra/data/raw/"
}


# create today's folder ----

access_date = Sys.Date()
today_folder = paste0(path, access_date, "/")
if (!dir.exists(today_folder)) {
  dir.create(today_folder)
}

# download setup ----
method = "curl" # maybe "curl", "wget", "libcurl", "auto", "internal", "wininet"
extra = "-L" # options for downloading files, passed to `download.file()`: used for "wget" and "curl" methods

# i_ipc.xlsx ----
url_from = "https://rosstat.gov.ru/storage/mediabank/a2Bf2bEU/i_ipc.xlsx"
# TODO: link does not work!!! Доступ запрещен :(
raw_path_to = "i_ipc.xlsx"
csv_path_to = "i_ipc.csv"
univariate = TRUE
frequency = 12
comment = "Monthly chained CPI from Russian Statistical Agency"

csv_path_to_full = paste0(today_folder, csv_path_to)
raw_path_to_full = paste0(today_folder, raw_path_to)

utils::download.file(url = url_from, destfile = raw_path_to_full, method = method, extra = extra)
if (length(grep("Доступ запрещен", read_lines(raw_path_to_full))) > 0) {
  warning("Probably file moved to another location")
  stop("Fucking `Access denied` inside a file :(")
}
data_processed = convert_i_ipc_xlsx(raw_path_to_full, access_date)
export_with_safe_date(data_processed, csv_path_to_full)
if (file.exists(raw_path_to_full)) {
  file.remove(raw_path_to_full)
}


# tab5a.xls ----
url_from = "http://www.gks.ru/free_doc/new_site/vvp/kv/tab5a.xls"
raw_path_to = "tab5a.xls"
csv_path_to = "tab5a.csv"
univariate = TRUE
frequency = 4
comment = "Gross domestic product quarterly current prices"

csv_path_to_full = paste0(today_folder, csv_path_to)
raw_path_to_full = paste0(today_folder, raw_path_to)

utils::download.file(url = url_from, destfile = raw_path_to_full, method = method, extra = extra)
if (length(grep("Доступ запрещен", read_lines(raw_path_to_full))) > 0) {
  warning("Probably file moved to another location")
  stop("Fucking `Access denied` inside a file :(")
}
data_processed = convert_tab5a_xls(raw_path_to_full, access_date)
export_with_safe_date(data_processed, csv_path_to_full)
if (file.exists(raw_path_to_full)) {
  file.remove(raw_path_to_full)
}



# tab9a.xls ----
url_from = "http://www.gks.ru/free_doc/new_site/vvp/kv/tab9a.xls"
raw_path_to = "tab9a.xls"
csv_path_to = "tab9a.csv"
univariate = TRUE
frequency = 4
comment = "Deflator index in percent to the previous quarter"

csv_path_to_full = paste0(today_folder, csv_path_to)
raw_path_to_full = paste0(today_folder, raw_path_to)

utils::download.file(url = url_from, destfile = raw_path_to_full, method = method, extra = extra)
if (length(grep("Доступ запрещен", read_lines(raw_path_to_full))) > 0) {
  warning("Probably file moved to another location")
  stop("Fucking `Access denied` inside a file :(")
}
data_processed = convert_tab9a_xls(raw_path_to_full, access_date)
export_with_safe_date(data_processed, csv_path_to_full)
if (file.exists(raw_path_to_full)) {
  file.remove(raw_path_to_full)
}


# tab9.xls ----
url_from = "http://www.gks.ru/free_doc/new_site/vvp/kv/tab9.xls"
raw_path_to = "tab9.xls"
csv_path_to = "tab9.csv"
univariate = TRUE
frequency = 4
comment = "Deflator index in percent to the previous quarter early data"

csv_path_to_full = paste0(today_folder, csv_path_to)
raw_path_to_full = paste0(today_folder, raw_path_to)

utils::download.file(url = url_from, destfile = raw_path_to_full, method = method, extra = extra)
if (length(grep("Доступ запрещен", read_lines(raw_path_to_full))) > 0) {
  warning("Probably file moved to another location")
  stop("Fucking `Access denied` inside a file :(")
}
data_processed = convert_tab9_xls(raw_path_to_full, access_date)
export_with_safe_date(data_processed, csv_path_to_full)
if (file.exists(raw_path_to_full)) {
  file.remove(raw_path_to_full)
}




# tab6b.xls ----
url_from = "http://www.gks.ru/free_doc/new_site/vvp/kv/tab6b.xls"
raw_path_to = "tab6b.xls"
csv_path_to = "tab6b.csv"
univariate = TRUE
frequency = 4
comment = "Gross domestic product quarterly 2016 prices"

csv_path_to_full = paste0(today_folder, csv_path_to)
raw_path_to_full = paste0(today_folder, raw_path_to)

utils::download.file(url = url_from, destfile = raw_path_to_full, method = method, extra = extra)
if (length(grep("Доступ запрещен", read_lines(raw_path_to_full))) > 0) {
  warning("Probably file moved to another location")
  stop("Fucking `Access denied` inside a file :(")
}
data_processed = convert_tab6b_xls(raw_path_to_full, access_date)
export_with_safe_date(data_processed, csv_path_to_full)
if (file.exists(raw_path_to_full)) {
  file.remove(raw_path_to_full)
}



# lendrate.html ----
# TODO: скачивать все даты!!!
url_from = "http://www.cbr.ru/hd_base/mkr/mkr_monthes/"
raw_path_to = "lendrate.html"
csv_path_to = "lendrate.csv"
univariate = FALSE
frequency = 12
comment = "Monthly lending rate multiple duration periods"

csv_path_to_full = paste0(today_folder, csv_path_to)
raw_path_to_full = paste0(today_folder, raw_path_to)

utils::download.file(url = url_from, destfile = raw_path_to_full, method = method, extra = extra)
if (length(grep("Доступ запрещен", read_lines(raw_path_to_full))) > 0) {
  warning("Probably file moved to another location")
  stop("Fucking `Access denied` inside a file :(")
}
data_processed = convert_lendrate(raw_path_to_full, access_date)
export_with_safe_date(data_processed, csv_path_to_full)
if (file.exists(raw_path_to_full)) {
  file.remove(raw_path_to_full)
}



# urov_12kv.doc ----
url_from = "http://www.gks.ru/free_doc/new_site/population/urov/urov_12kv.doc"
raw_path_to = "urov_12kv.doc"
csv_path_to = "urov_12kv.csv"
univariate = FALSE
frequency = 12
comment = "Real disposable income percentage to previous period and to same month of previous year"

csv_path_to_full = paste0(today_folder, csv_path_to)
raw_path_to_full = paste0(today_folder, raw_path_to)

utils::download.file(url = url_from, destfile = raw_path_to_full, method = method, extra = extra)
if (length(grep("Доступ запрещен", read_lines(raw_path_to_full))) > 0) {
  warning("Probably file moved to another location")
  stop("Fucking `Access denied` inside a file :(")
}
data_processed = convert_urov_12kv_doc(raw_path_to_full, access_date)
export_with_safe_date(data_processed, csv_path_to_full)
if (file.exists(raw_path_to_full)) {
  file.remove(raw_path_to_full)
}



# 1-08.doc ----
url_from = "http://www.gks.ru/bgd/regl/b18_02/IssWWW.exe/Stg/d010/1-08.doc"
raw_path_to = "1-08.doc"
csv_path_to = "1-08.csv"
univariate = TRUE
frequency = 12
comment = "Agricultural index"

csv_path_to_full = paste0(today_folder, csv_path_to)
raw_path_to_full = paste0(today_folder, raw_path_to)

utils::download.file(url = url_from, destfile = raw_path_to_full, method = method, extra = extra)
if (length(grep("Доступ запрещен", read_lines(raw_path_to_full))) > 0) {
  warning("Probably file moved to another location")
  stop("Fucking `Access denied` inside a file :(")
}
data_processed = convert_1_nn_doc(raw_path_to_full, access_date)
export_with_safe_date(data_processed, csv_path_to_full)
if (file.exists(raw_path_to_full)) {
  file.remove(raw_path_to_full)
}









# 1-03.doc ----
url_from = "http://www.gks.ru/bgd/regl/b18_02/IssWWW.exe/Stg/d010/1-03.doc"
raw_path_to = "1-03.doc"
csv_path_to = "1-03.csv"
univariate = TRUE
frequency = 12
comment = "Construction"

csv_path_to_full = paste0(today_folder, csv_path_to)
raw_path_to_full = paste0(today_folder, raw_path_to)

utils::download.file(url = url_from, destfile = raw_path_to_full, method = method, extra = extra)
if (length(grep("Доступ запрещен", read_lines(raw_path_to_full))) > 0) {
  warning("Probably file moved to another location")
  stop("Fucking `Access denied` inside a file :(")
}
data_processed = convert_1_nn_doc(raw_path_to_full, access_date)
export_with_safe_date(data_processed, csv_path_to_full)
if (file.exists(raw_path_to_full)) {
  file.remove(raw_path_to_full)
}









# 1-11.doc ----
url_from = "http://www.gks.ru/bgd/regl/b18_02/IssWWW.exe/Stg/d010/1-11.doc"
raw_path_to = "1-11.doc"
csv_path_to = "1-11.csv"
univariate = TRUE
frequency = 12
comment = "Budget"

csv_path_to_full = paste0(today_folder, csv_path_to)
raw_path_to_full = paste0(today_folder, raw_path_to)

utils::download.file(url = url_from, destfile = raw_path_to_full, method = method, extra = extra)
if (length(grep("Доступ запрещен", read_lines(raw_path_to_full))) > 0) {
  warning("Probably file moved to another location")
  stop("Fucking `Access denied` inside a file :(")
}
data_processed = convert_1_nn_doc(raw_path_to_full, access_date)
export_with_safe_date(data_processed, csv_path_to_full)
if (file.exists(raw_path_to_full)) {
  file.remove(raw_path_to_full)
}









# m2-m2_sa.xlsx ----
url_from = "http://www.cbr.ru/vfs/statistics/credit_statistics/M2-M2_SA.xlsx"
raw_path_to = "m2-m2_sa.xlsx"
csv_path_to = "m2-m2_sa.csv"
univariate = TRUE
frequency = 12
comment = "Seasonally adjusted M2"

csv_path_to_full = paste0(today_folder, csv_path_to)
raw_path_to_full = paste0(today_folder, raw_path_to)

utils::download.file(url = url_from, destfile = raw_path_to_full, method = method, extra = extra)
if (length(grep("Доступ запрещен", read_lines(raw_path_to_full))) > 0) {
  warning("Probably file moved to another location")
  stop("Fucking `Access denied` inside a file :(")
}
data_processed = convert_m2_m2_sa_xlsx(raw_path_to_full, access_date)
export_with_safe_date(data_processed, csv_path_to_full)
if (file.exists(raw_path_to_full)) {
  file.remove(raw_path_to_full)
}










# reserves.html ----
# TODO: скачивать все даты!!! Сейчас только с 2019
url_from = "http://www.cbr.ru/hd_base/mrrf/mrrf_m/"
raw_path_to = "reserves.html"
csv_path_to = "reserves.csv"
univariate = FALSE
frequency = 12
comment = "Reserves data from cbr"

csv_path_to_full = paste0(today_folder, csv_path_to)
raw_path_to_full = paste0(today_folder, raw_path_to)

utils::download.file(url = url_from, destfile = raw_path_to_full, method = method, extra = extra)
if (length(grep("Доступ запрещен", read_lines(raw_path_to_full))) > 0) {
  warning("Probably file moved to another location")
  stop("Fucking `Access denied` inside a file :(")
}
data_processed = convert_reserves(raw_path_to_full, access_date)
export_with_safe_date(data_processed, csv_path_to_full)
if (file.exists(raw_path_to_full)) {
  file.remove(raw_path_to_full)
}




# ind_okved2.xlsx ----
url_from = "http://www.gks.ru/free_doc/new_site/business/prom/ind_okved2.xlsx"
raw_path_to = "ind_okved2.xlsx"
csv_path_to = "ind_okved2.csv"
univariate = FALSE
frequency = NA
comment = "Industrial production index"

csv_path_to_full = paste0(today_folder, csv_path_to)
raw_path_to_full = paste0(today_folder, raw_path_to)

utils::download.file(url = url_from, destfile = raw_path_to_full, method = method, extra = extra)
if (length(grep("Доступ запрещен", read_lines(raw_path_to_full))) > 0) {
  warning("Probably file moved to another location")
  stop("Fucking `Access denied` inside a file :(")
}
data_processed = convert_ind_okved2_xlsx(raw_path_to_full, access_date)
export_with_safe_date(data_processed, csv_path_to_full)
if (file.exists(raw_path_to_full)) {
  file.remove(raw_path_to_full)
}




# trade.xls ----
url_from = "https://www.cbr.ru/vfs/statistics/credit_statistics/trade/trade.xls"
raw_path_to = "trade.xls"
csv_path_to = "trade.csv"
univariate = FALSE
frequency = 12
comment = "Trade statistics"

csv_path_to_full = paste0(today_folder, csv_path_to)
raw_path_to_full = paste0(today_folder, raw_path_to)

utils::download.file(url = url_from, destfile = raw_path_to_full, method = method, extra = extra)
if (length(grep("Доступ запрещен", read_lines(raw_path_to_full))) > 0) {
  warning("Probably file moved to another location")
  stop("Fucking `Access denied` inside a file :(")
}
data_processed = convert_trade_xls(raw_path_to_full, access_date)
export_with_safe_date(data_processed, csv_path_to_full)
if (file.exists(raw_path_to_full)) {
  file.remove(raw_path_to_full)
}




# 1-06-0.xlsx ----
url_from = "http://www.gks.ru/bgd/regl/b20_02/IssWWW.exe/Stg/d010/1-06-0.xlsx"
raw_path_to = "1-06-0.xlsx"
csv_path_to = "invest.csv"
univariate = TRUE
frequency = 4
comment = "Fixed capital investment"

csv_path_to_full = paste0(today_folder, csv_path_to)
raw_path_to_full = paste0(today_folder, raw_path_to)

utils::download.file(url = url_from, destfile = raw_path_to_full, method = method, extra = extra)
if (length(grep("Доступ запрещен", read_lines(raw_path_to_full))) > 0) {
  warning("Probably file moved to another location")
  stop("Fucking `Access denied` inside a file :(")
}
data_processed = convert_1_06_0_xlsx(raw_path_to_full, access_date)
export_with_safe_date(data_processed, csv_path_to_full)
if (file.exists(raw_path_to_full)) {
  file.remove(raw_path_to_full)
}



# exchangerate.csv ----
csv_path_to = "exchangerate.csv"
univariate = TRUE
frequency = NA
comment = "NA Exchange rate from cbr"

csv_path_to_full = paste0(today_folder, csv_path_to)

data_processed = parse_exchangerate(access_date)
export_with_safe_date(data_processed, csv_path_to_full)



# ind_baza_2018.xlsx ----
# TODO: ссылка не работает!! Доступ запрещен
url_from = "https://rosstat.gov.ru/storage/mediabank/H1EwGY8H/ind_baza-2018.xlsx"
raw_path_to = "ind_baza_2018.xlsx"
csv_path_to = "ind_baza_2018.csv"
univariate = FALSE
frequency = NA
comment = "Industrial production index, new edition, base year = 2018"

csv_path_to_full = paste0(today_folder, csv_path_to)
raw_path_to_full = paste0(today_folder, raw_path_to)

utils::download.file(url = url_from, destfile = raw_path_to_full, method = method, extra = extra)
if (length(grep("Доступ запрещен", read_lines(raw_path_to_full))) > 0) {
  warning("Probably file moved to another location")
  stop("Fucking `Access denied` inside a file :(")
}
data_processed = convert_ind_okved2_xlsx(raw_path_to_full, access_date)
export_with_safe_date(data_processed, csv_path_to_full)
if (file.exists(raw_path_to_full)) {
  file.remove(raw_path_to_full)
}









