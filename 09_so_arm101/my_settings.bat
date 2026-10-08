@echo off
REM ============================================================
REM  SO-ARM101 + LeRobot : my settings
REM  1) Edit the values below (ports, ids, HF user name).
REM  2) Save as C:\robot\my_settings.bat  (file type: All Files)
REM  3) Run it in "Miniforge Prompt" each time:  C:\robot\my_settings.bat
REM  NOTE: keep this file in English only (no Korean characters).
REM ============================================================

REM --- go into the lerobot virtual environment and folder ---
call conda activate lerobot
cd /d C:\robot\lerobot

REM --- USB ports found with: lerobot-find-port ---
set "FOLLOWER_PORT=COM4"
set "LEADER_PORT=COM3"

REM --- arm names (calibration files are saved with these names) ---
REM     Do NOT change them after calibration.
set "FOLLOWER_ID=my_follower"
set "LEADER_ID=my_leader"

REM --- camera indexes found with: lerobot-find-cameras opencv ---
set "CAM_FRONT=0"
set "CAM_SIDE=1"
set "CAMERAS={ front: {type: opencv, index_or_path: %CAM_FRONT%, width: 640, height: 480, fps: 30}, side: {type: opencv, index_or_path: %CAM_SIDE%, width: 640, height: 480, fps: 30}}"

REM --- Hugging Face user name (optional, for uploading) ---
set "HF_USER=student"

echo ========================================
echo  FOLLOWER_PORT = %FOLLOWER_PORT%    FOLLOWER_ID = %FOLLOWER_ID%
echo  LEADER_PORT   = %LEADER_PORT%    LEADER_ID   = %LEADER_ID%
echo  CAM_FRONT = %CAM_FRONT%   CAM_SIDE = %CAM_SIDE%   HF_USER = %HF_USER%
echo ========================================
