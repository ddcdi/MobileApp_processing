import controlP5.*;
import ddf.minim.*; // Minim 라이브러리 임포트

public class IOT_service {
    float pos;
    ControlP5 cp5;
    PImage[] app_IOT = new PImage[4]; // 화면 이미지 배열
    PImage button_1, button_2, button_3, arrow_left; // 이미지 변수 선언
    int currentScreen = 0; // 현재 화면 인덱스

    PImage [] temp_image = new PImage[3];
    int currentTempImage = 0;
    PImage temp_control_button;

    PApplet p;
    PImage[] light = new PImage[2];   // 조명 상태 이미지 배열 (0: 켜짐, 1: 꺼짐)
    PImage[] toggle = new PImage[2]; // 토글 상태 이미지 배열 (0: 켜짐, 1: 꺼짐)
    PImage[] sound_button = new PImage[2]; // 음향 재생 버튼 이미지 배열 (0: 재생중, 1: 중지)
    PImage sound_next_button,sound_prev_button; // 음향 다음, 이전 버튼 이미지 변수 선언

    // Minim 관련 변수 선언
    Minim minim;
    AudioPlayer[] music_files = new AudioPlayer[2];
    PImage[] musicImages = new PImage[2];
    int currentSongIndex = 0;  // 현재 음악 인덱스

    float progressBarX = 175.39;      // 재생바 x좌표
    float progressBarY = 209.73;     // 재생바 y좌표
    float progressBarWidth;       // 재생바 길이
    float progressBarHeight;      // 재생바 높이

    boolean isPlaying = false;    // 음악 재생 상태
    PImage progressBarBackground; // 재생바 배경 이미지
    PImage progressIcon;          // 진행 아이콘 이미지

    // 토글 상태를 관리할 배열 또는 리스트
    boolean[] lightStates;

    public IOT_service(PApplet p) {
        this.p = p;
        cp5 = new ControlP5(p); // ControlP5 초기화
        // 토글 개수만큼 상태 배열 초기화
        lightStates = new boolean[5]; // 5개의 조명 토글
    }

    public void cleanup() {
        music_files[0].close();
        music_files[1].close();
        minim.stop();
    }

    public void setup() {
        // 이미지 로드
        app_IOT[0] = p.loadImage("IOT 제어 위젯.png");
        app_IOT[1] = p.loadImage("IOT_온도.png");
        app_IOT[2] = p.loadImage("IOT_조명.png");
        app_IOT[3] = musicImages[currentSongIndex];

        // 버튼 이미지 로드
        button_1 = p.loadImage("음향/Component 1.png");
        button_2 = p.loadImage("음향/Component 2.png");
        button_3 = p.loadImage("음향/Component 3.png");
        arrow_left = p.loadImage("arrow-left.png");

        // 메인 화면 버튼들
        cp5.addButton("온도")
            .setPosition(56.8, 200.41)
            .setSize(24, 24)
            .setImage(button_1)
            .updateSize()
            .onClick(event -> {
                currentScreen = 1;
                updateButtonVisibility();
            });

        cp5.addButton("조명")
            .setPosition(89, 200.41)
            .setSize(24, 24)
            .setImage(button_2)
            .updateSize()
            .onClick(event -> {
                currentScreen = 2;
                updateButtonVisibility();
            });

        cp5.addButton("음향")
            .setPosition(120.27, 200.41)
            .setSize(24, 24)
            .setImage(button_3)
            .updateSize()
            .onClick(event -> {
                currentScreen = 3;
                updateButtonVisibility();
            });

        // 뒤로가기 버튼 (초기에는 숨김)
        cp5.addButton("뒤로가기")
            .setPosition(343, 107)
            .setSize(12, 12)
            .setImage(arrow_left)
            .updateSize()
            .onClick(event -> {
                currentScreen = 0;
                updateButtonVisibility();
            });

        float[][] initialPositions = {
            {56.8, 200.41},  // 버튼 1 위치
            {89, 200.41}, // 버튼 2 위치
            {120.27, 200.41}  // 버튼 3 위치
        };

        // ########################################################### 온도제어 ###########################################################
        temp_image[0] = p.loadImage("IOT_온도.png");
        temp_image[1] = p.loadImage("IOT_온도2.png");
        temp_image[2] = p.loadImage("IOT_온도3.png");
        temp_control_button = p.loadImage("invisible.png");
        // 모드 제어 버튼
        cp5.addButton("온도제어")
            .setPosition(100, 214)
            .setSize(59, 24)
            .setImage(temp_control_button)
            .updateSize()
            .onClick(event -> {
                currentTempImage = (currentTempImage + 1) % temp_image.length;
                updateButtonVisibility();
            });

        // ########################################################### 조명제어 ###########################################################
        light[0] = p.loadImage("light_on.png");
        light[1] = p.loadImage("light_off.png");
        toggle[0] = p.loadImage("Toggle.png");
        toggle[1] = p.loadImage("Toggle_off.png");
        
        // 초기 상태: 모든 조명 꺼짐
        for (int i = 0; i < lightStates.length; i++) {
            lightStates[i] = false;
        }

        // 토글 버튼 위치 배열
        float[][] togglePositions = {
            {70, 210},   // 1번 토글 버튼 위치
            {128, 210},   // 2번 토글 버튼 위치
            {186, 210},   // 3번 토글 버튼 위치
            {244, 210},   // 4번 토글 버튼 위치
            {302, 210}    // 5번 토글 버튼 위치
        };

        // 조명제어 토글 버튼 동적 생성
        for (int i = 0; i < 5; i++) {
            final int index = i;
            cp5.addButton("조명토글_" + i)
                .setPosition(togglePositions[i][0], togglePositions[i][1])
                .setSize(33, 20)
                .setImage(toggle[1]) // 초기 이미지는 off
                .updateSize()
                .onClick(event -> {
                    // 상태 토글
                    lightStates[index] = !lightStates[index];
                    
                    // 해당 버튼 이미지 변경
                    if (lightStates[index]) {
                        cp5.get(Button.class, "조명토글_" + index).setImage(toggle[0]);
                    } else {
                        cp5.get(Button.class, "조명토글_" + index).setImage(toggle[1]);
                    }

                    // 해당 조명의 상태에 맞는 이미지 변경
                    updateLightingImages();
                });
        }

        // ########################################################### 음향제어 ###########################################################

        minim = new Minim(p);
        music_files[0] = minim.loadFile("Taylor Swift willow.mp3");
        music_files[1] = minim.loadFile("John.mp3");
        musicImages[0] = loadImage("IOT_음향2.png");
        musicImages[1] = loadImage("IOT_음향3.png");

        sound_next_button = loadImage("sound_next.png");
        sound_prev_button = loadImage("sound_prev.png");
        sound_button[0] = loadImage("sound_playing.png");
        sound_button[1] = loadImage("sound_pause.png");

        progressBarBackground = loadImage("progress_bar.png"); // 재생바 배경 이미지
        progressIcon = loadImage("progress_icon.png");           // 아이콘 이미지

        // 재생바 크기 초기화 (이미지 크기에 맞춤)
        progressBarWidth = progressBarBackground.width;
        progressBarHeight = progressBarBackground.height;

        cp5.addButton("음악 재생")
          .setPosition(246,181)
          .setSize(14, 16)
          .setImage(sound_button[1]) // 초기 이미지 정지
          .updateSize()
          .onClick(event -> {
            if (music_files[currentSongIndex].isPlaying()) {
              music_files[currentSongIndex].pause();
              isPlaying = false;
              cp5.get(Button.class,"음악 재생").setImage(sound_button[1]);
            } else {
              music_files[currentSongIndex].play();
              isPlaying = true;
              cp5.get(Button.class,"음악 재생").setImage(sound_button[0]);
            }
          });

        cp5.addButton("음악 이전")
          .setPosition(209,183)
          .setSize(13, 13)
          .setImage(sound_prev_button)
          .updateSize()
          .onClick(event -> {
            music_files[currentSongIndex].pause();
            currentSongIndex = (currentSongIndex + 1) % music_files.length;
            music_files[currentSongIndex].play();
            cp5.get(Button.class,"음악 재생").setImage(sound_button[0]);
          });

        cp5.addButton("음악 다음")
          .setPosition(283,183)
          .setSize(13, 13)
          .setImage(sound_next_button)
          .updateSize()
          .onClick(event -> {
            music_files[currentSongIndex].pause();
            currentSongIndex = (currentSongIndex + 1) % music_files.length;
            music_files[currentSongIndex].play();
            cp5.get(Button.class,"음악 재생").setImage(sound_button[0]);
          });

        // 초기 버튼 가시성 설정
        updateButtonVisibility();
    }

    private void updateButtonVisibility() {
        // 모든 버튼 숨기기
        cp5.get("온도").hide();
        cp5.get("조명").hide();
        cp5.get("음향").hide();
        cp5.get("뒤로가기").hide();
        cp5.get("음악 재생").hide();
        cp5.get("음악 이전").hide();
        cp5.get("음악 다음").hide();
        cp5.get("온도제어").hide();
        // 초기에 토글 버튼 숨기기
        for (int i = 0; i < 5; i++) {
            cp5.get("조명토글_" + i).hide();
        }

        // 메인 화면일 때
        if (currentScreen == 0) {
            cp5.get("온도").show();
            cp5.get("조명").show();
            cp5.get("음향").show();
        } 
        // 서브 화면들일 때
        else if (currentScreen == 1) {
            cp5.get("뒤로가기").show();
            cp5.get("온도제어").show();
        }
        else if (currentScreen == 2) {
            updateLightingImages();
            for (int i = 0; i < 5; i++) {
                cp5.get("조명토글_" + i).show();
            }
            cp5.get("뒤로가기").show();
        }
        else if (currentScreen == 3) {
            cp5.get("뒤로가기").show();
            cp5.get("음악 재생").show();
            cp5.get("음악 이전").show();
            cp5.get("음악 다음").show();
        }
    }

    private void hideButtons(){
        cp5.get("온도").hide();
        cp5.get("조명").hide();
        cp5.get("음향").hide();
    }

    public void draw() {
        // 메인 화면
        if (currentScreen == 0) {
            p.image(app_IOT[currentScreen], 32, 94);
            cp5.get("온도").setPosition(56.8, 200.41 + pos);
            cp5.get("조명").setPosition(89, 200.41 + pos);
            cp5.get("음향").setPosition(120.27, 200.41 + pos);
        } 

        // 온도
        if (currentScreen == 1) {
            p.image(temp_image[currentTempImage], 32, 94);
        } 

        // 조명
        if (currentScreen == 2) {
            p.image(app_IOT[currentScreen], 32, 94);
            updateLightingImages();
        }

        // 음향
        if (currentScreen == 3) {
        // 음악에 맞는 화면 설정

        p.image(musicImages[currentSongIndex], 32, 94);
        
        // 재생바 배경 표시
        image(progressBarBackground, progressBarX, progressBarY);
        // 현재 진행률 계산 (0 ~ progressBarWidth)
        float progress = map(music_files[currentSongIndex].position(), 0, music_files[currentSongIndex].length(), 0, progressBarWidth);
        // 아이콘 위치 계산
        float sound_iconX = progressBarX + progress;  // 진행률에 따른 아이콘의 x좌표
        float sound_iconY = progressBarY + (progressBarHeight / 2) - (progressIcon.height / 2); // y좌표는 재생바 중앙 정렬
        // 아이콘 표시
        image(progressIcon, sound_iconX, sound_iconY);
        }
    }    

    public void setScreen(int screenIndex) {
        currentScreen = screenIndex;
        updateButtonVisibility();
    }

    // 조명 상태에 맞는 이미지 업데이트
    public void updateLightingImages() {

      // 여러 조명 위치
      float[][] lightPositions = {
          {63, 113},  // 1번 조명 위치
          {121, 113},  // 2번 조명 위치
          {179, 113},  // 3번 조명 위치
          {237, 113},  // 4번 조명 위치
          {295, 113}   // 5번 조명 위치
      };

      for (int i = 0; i < 5; i++) {
        if (lightStates[i]) {
          // 조명이 켜져 있으면 조명_on 이미지를 설정
          p.image(light[0], lightPositions[i][0]-12,lightPositions[i][1]-14);
        } else {
          // 조명이 꺼져 있으면 조명_off 이미지를 설정
          p.image(light[1], lightPositions[i][0],lightPositions[i][1]);
        }
      }
    }

    public void setPos(float pos) {
        this.pos = pos;
    }

}
