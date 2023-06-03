.class public Lcom/adobe/air/FlashEGL10;
.super Ljava/lang/Object;
.source "FlashEGL10.java"

# interfaces
.implements Lcom/adobe/air/FlashEGL;


# static fields
.field private static EGL_BUFFER_DESTROYED:I

.field private static EGL_BUFFER_PRESERVED:I

.field private static EGL_CONTEXT_CLIENT_VERSION:I

.field private static EGL_COVERAGE_BUFFERS_NV:I

.field private static EGL_COVERAGE_SAMPLES_NV:I

.field private static EGL_OPENGL_ES2_BIT:I

.field private static EGL_SWAP_BEHAVIOR:I

.field private static TAG:Ljava/lang/String;

.field private static cfgAttrs:[I

.field private static fbPBufferSurfaceAttrs:[I

.field private static fbWindowSurfaceOffAttrs:[I

.field private static fbWindowSurfaceOnAttrs:[I


# instance fields
.field private kAlphaBits:I

.field private kBlueBits:I

.field private kColorBits:I

.field private kConfigId:I

.field private kCsaaSamp:I

.field private kDepthBits:I

.field private kGreenBits:I

.field private kMsaaSamp:I

.field private kNumElements:I

.field private kRedBits:I

.field private kStencilBits:I

.field private kSurfaceTypes:I

.field private kSwapPreserve:I

.field private kSwapPreserveDefault:I

.field private kSwapPreserveOff:I

.field private kSwapPreserveOn:I

.field private mEgl:Ljavax/microedition/khronos/egl/EGL10;

.field private mEglConfig:Ljavax/microedition/khronos/egl/EGLConfig;

.field private mEglConfigCount:I

.field private mEglConfigList:[Ljavax/microedition/khronos/egl/EGLConfig;

.field volatile mEglContext:Ljavax/microedition/khronos/egl/EGLContext;

.field private mEglDisplay:Ljavax/microedition/khronos/egl/EGLDisplay;

.field private mEglPbufferSurface:Ljavax/microedition/khronos/egl/EGLSurface;

.field private mEglSurface:Ljavax/microedition/khronos/egl/EGLSurface;

.field private mEglVersion:[I

.field private mEglWindowSurface:Ljavax/microedition/khronos/egl/EGLSurface;

.field private mIsARGBSurface:Z

.field private mIsBufferPreserve:Z

.field private mIsES3Device:Z

.field private mIsGPUOOM:Z

.field private mPbufferConfigCount:I

.field private mPixmapConfigCount:I

.field private mWindowConfigCount:I


# direct methods
.method static constructor <clinit>()V
    .locals 8

    .prologue
    const/4 v7, 0x3

    const/4 v6, 0x2

    const/4 v5, 0x1

    const/4 v4, 0x0

    const/4 v3, -0x1

    .line 32
    const-string v0, "FlashEGL10"

    sput-object v0, Lcom/adobe/air/FlashEGL10;->TAG:Ljava/lang/String;

    .line 33
    const/16 v0, 0x3098

    sput v0, Lcom/adobe/air/FlashEGL10;->EGL_CONTEXT_CLIENT_VERSION:I

    .line 34
    const/4 v0, 0x4

    sput v0, Lcom/adobe/air/FlashEGL10;->EGL_OPENGL_ES2_BIT:I

    .line 36
    const/16 v0, 0x30e0

    sput v0, Lcom/adobe/air/FlashEGL10;->EGL_COVERAGE_BUFFERS_NV:I

    .line 37
    const/16 v0, 0x30e1

    sput v0, Lcom/adobe/air/FlashEGL10;->EGL_COVERAGE_SAMPLES_NV:I

    .line 40
    const/16 v0, 0x3093

    sput v0, Lcom/adobe/air/FlashEGL10;->EGL_SWAP_BEHAVIOR:I

    .line 41
    const/16 v0, 0x3094

    sput v0, Lcom/adobe/air/FlashEGL10;->EGL_BUFFER_PRESERVED:I

    .line 42
    const/16 v0, 0x3095

    sput v0, Lcom/adobe/air/FlashEGL10;->EGL_BUFFER_DESTROYED:I

    .line 52
    const/16 v0, 0x9

    new-array v0, v0, [I

    const/16 v1, 0x3033

    aput v1, v0, v4

    aput v3, v0, v5

    const/16 v1, 0x3025

    aput v1, v0, v6

    aput v3, v0, v7

    const/4 v1, 0x4

    const/16 v2, 0x3026

    aput v2, v0, v1

    const/4 v1, 0x5

    aput v3, v0, v1

    const/4 v1, 0x6

    const/16 v2, 0x3040

    aput v2, v0, v1

    const/4 v1, 0x7

    sget v2, Lcom/adobe/air/FlashEGL10;->EGL_OPENGL_ES2_BIT:I

    aput v2, v0, v1

    const/16 v1, 0x8

    const/16 v2, 0x3038

    aput v2, v0, v1

    sput-object v0, Lcom/adobe/air/FlashEGL10;->cfgAttrs:[I

    .line 62
    new-array v0, v7, [I

    sget v1, Lcom/adobe/air/FlashEGL10;->EGL_SWAP_BEHAVIOR:I

    aput v1, v0, v4

    sget v1, Lcom/adobe/air/FlashEGL10;->EGL_BUFFER_PRESERVED:I

    aput v1, v0, v5

    const/16 v1, 0x3038

    aput v1, v0, v6

    sput-object v0, Lcom/adobe/air/FlashEGL10;->fbWindowSurfaceOnAttrs:[I

    .line 68
    new-array v0, v7, [I

    sget v1, Lcom/adobe/air/FlashEGL10;->EGL_SWAP_BEHAVIOR:I

    aput v1, v0, v4

    sget v1, Lcom/adobe/air/FlashEGL10;->EGL_BUFFER_DESTROYED:I

    aput v1, v0, v5

    const/16 v1, 0x3038

    aput v1, v0, v6

    sput-object v0, Lcom/adobe/air/FlashEGL10;->fbWindowSurfaceOffAttrs:[I

    .line 74
    const/4 v0, 0x5

    new-array v0, v0, [I

    fill-array-data v0, :array_0

    sput-object v0, Lcom/adobe/air/FlashEGL10;->fbPBufferSurfaceAttrs:[I

    return-void

    nop

    :array_0
    .array-data 4
        0x3057
        0x40
        0x3056
        0x40
        0x3038
    .end array-data
.end method

.method public constructor <init>()V
    .locals 5

    .prologue
    const/4 v4, 0x2

    const/4 v3, 0x1

    const/4 v2, 0x0

    const/4 v1, 0x0

    .line 30
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 44
    iput v1, p0, Lcom/adobe/air/FlashEGL10;->kSurfaceTypes:I

    iput v3, p0, Lcom/adobe/air/FlashEGL10;->kConfigId:I

    iput v4, p0, Lcom/adobe/air/FlashEGL10;->kRedBits:I

    const/4 v0, 0x3

    iput v0, p0, Lcom/adobe/air/FlashEGL10;->kGreenBits:I

    const/4 v0, 0x4

    iput v0, p0, Lcom/adobe/air/FlashEGL10;->kBlueBits:I

    const/4 v0, 0x5

    iput v0, p0, Lcom/adobe/air/FlashEGL10;->kAlphaBits:I

    const/4 v0, 0x6

    iput v0, p0, Lcom/adobe/air/FlashEGL10;->kColorBits:I

    const/4 v0, 0x7

    iput v0, p0, Lcom/adobe/air/FlashEGL10;->kDepthBits:I

    const/16 v0, 0x8

    iput v0, p0, Lcom/adobe/air/FlashEGL10;->kStencilBits:I

    const/16 v0, 0x9

    iput v0, p0, Lcom/adobe/air/FlashEGL10;->kMsaaSamp:I

    const/16 v0, 0xa

    iput v0, p0, Lcom/adobe/air/FlashEGL10;->kCsaaSamp:I

    const/16 v0, 0xb

    iput v0, p0, Lcom/adobe/air/FlashEGL10;->kSwapPreserve:I

    const/16 v0, 0xc

    iput v0, p0, Lcom/adobe/air/FlashEGL10;->kNumElements:I

    .line 49
    iput v1, p0, Lcom/adobe/air/FlashEGL10;->kSwapPreserveDefault:I

    iput v3, p0, Lcom/adobe/air/FlashEGL10;->kSwapPreserveOn:I

    iput v4, p0, Lcom/adobe/air/FlashEGL10;->kSwapPreserveOff:I

    .line 845
    iput-object v2, p0, Lcom/adobe/air/FlashEGL10;->mEgl:Ljavax/microedition/khronos/egl/EGL10;

    .line 846
    sget-object v0, Ljavax/microedition/khronos/egl/EGL10;->EGL_NO_DISPLAY:Ljavax/microedition/khronos/egl/EGLDisplay;

    iput-object v0, p0, Lcom/adobe/air/FlashEGL10;->mEglDisplay:Ljavax/microedition/khronos/egl/EGLDisplay;

    .line 847
    sget-object v0, Ljavax/microedition/khronos/egl/EGL10;->EGL_NO_SURFACE:Ljavax/microedition/khronos/egl/EGLSurface;

    iput-object v0, p0, Lcom/adobe/air/FlashEGL10;->mEglSurface:Ljavax/microedition/khronos/egl/EGLSurface;

    .line 848
    sget-object v0, Ljavax/microedition/khronos/egl/EGL10;->EGL_NO_SURFACE:Ljavax/microedition/khronos/egl/EGLSurface;

    iput-object v0, p0, Lcom/adobe/air/FlashEGL10;->mEglWindowSurface:Ljavax/microedition/khronos/egl/EGLSurface;

    .line 849
    sget-object v0, Ljavax/microedition/khronos/egl/EGL10;->EGL_NO_SURFACE:Ljavax/microedition/khronos/egl/EGLSurface;

    iput-object v0, p0, Lcom/adobe/air/FlashEGL10;->mEglPbufferSurface:Ljavax/microedition/khronos/egl/EGLSurface;

    .line 850
    iput-object v2, p0, Lcom/adobe/air/FlashEGL10;->mEglConfig:Ljavax/microedition/khronos/egl/EGLConfig;

    .line 851
    iput-object v2, p0, Lcom/adobe/air/FlashEGL10;->mEglConfigList:[Ljavax/microedition/khronos/egl/EGLConfig;

    .line 852
    iput-object v2, p0, Lcom/adobe/air/FlashEGL10;->mEglVersion:[I

    .line 853
    iput v1, p0, Lcom/adobe/air/FlashEGL10;->mEglConfigCount:I

    .line 854
    iput v1, p0, Lcom/adobe/air/FlashEGL10;->mWindowConfigCount:I

    .line 855
    iput v1, p0, Lcom/adobe/air/FlashEGL10;->mPixmapConfigCount:I

    .line 856
    iput v1, p0, Lcom/adobe/air/FlashEGL10;->mPbufferConfigCount:I

    .line 857
    sget-object v0, Ljavax/microedition/khronos/egl/EGL10;->EGL_NO_CONTEXT:Ljavax/microedition/khronos/egl/EGLContext;

    iput-object v0, p0, Lcom/adobe/air/FlashEGL10;->mEglContext:Ljavax/microedition/khronos/egl/EGLContext;

    .line 858
    iput-boolean v1, p0, Lcom/adobe/air/FlashEGL10;->mIsARGBSurface:Z

    .line 859
    iput-boolean v1, p0, Lcom/adobe/air/FlashEGL10;->mIsGPUOOM:Z

    .line 860
    iput-boolean v1, p0, Lcom/adobe/air/FlashEGL10;->mIsBufferPreserve:Z

    .line 861
    iput-boolean v1, p0, Lcom/adobe/air/FlashEGL10;->mIsES3Device:Z

    return-void
.end method

.method private XX(II)I
    .locals 1
    .param p1, "i"    # I
    .param p2, "a"    # I

    .prologue
    .line 99
    iget v0, p0, Lcom/adobe/air/FlashEGL10;->kNumElements:I

    mul-int/2addr v0, p1

    add-int/2addr v0, p2

    return v0
.end method

.method private checkEglError(Ljava/lang/String;)I
    .locals 8
    .param p1, "prompt"    # Ljava/lang/String;

    .prologue
    const/16 v7, 0x3000

    .line 805
    iget-object v2, p0, Lcom/adobe/air/FlashEGL10;->mEgl:Ljavax/microedition/khronos/egl/EGL10;

    invoke-interface {v2}, Ljavax/microedition/khronos/egl/EGL10;->eglGetError()I

    move-result v1

    .line 806
    .local v1, "error":I
    if-eq v1, v7, :cond_3

    .line 808
    iget-boolean v2, p0, Lcom/adobe/air/FlashEGL10;->mIsGPUOOM:Z

    if-nez v2, :cond_3

    const/16 v2, 0x3003

    if-ne v1, v2, :cond_3

    .line 813
    iget-object v2, p0, Lcom/adobe/air/FlashEGL10;->mEglWindowSurface:Ljavax/microedition/khronos/egl/EGLSurface;

    sget-object v3, Ljavax/microedition/khronos/egl/EGL10;->EGL_NO_SURFACE:Ljavax/microedition/khronos/egl/EGLSurface;

    if-eq v2, v3, :cond_1

    .line 815
    iget-object v2, p0, Lcom/adobe/air/FlashEGL10;->mEgl:Ljavax/microedition/khronos/egl/EGL10;

    iget-object v3, p0, Lcom/adobe/air/FlashEGL10;->mEglDisplay:Ljavax/microedition/khronos/egl/EGLDisplay;

    iget-object v4, p0, Lcom/adobe/air/FlashEGL10;->mEglWindowSurface:Ljavax/microedition/khronos/egl/EGLSurface;

    invoke-interface {v2, v3, v4}, Ljavax/microedition/khronos/egl/EGL10;->eglDestroySurface(Ljavax/microedition/khronos/egl/EGLDisplay;Ljavax/microedition/khronos/egl/EGLSurface;)Z

    .line 816
    iget-object v2, p0, Lcom/adobe/air/FlashEGL10;->mEgl:Ljavax/microedition/khronos/egl/EGL10;

    invoke-interface {v2}, Ljavax/microedition/khronos/egl/EGL10;->eglGetError()I

    move-result v0

    .line 817
    .local v0, "_error":I
    sget-object v2, Ljavax/microedition/khronos/egl/EGL10;->EGL_NO_SURFACE:Ljavax/microedition/khronos/egl/EGLSurface;

    iput-object v2, p0, Lcom/adobe/air/FlashEGL10;->mEglWindowSurface:Ljavax/microedition/khronos/egl/EGLSurface;

    .line 818
    sget-object v2, Ljavax/microedition/khronos/egl/EGL10;->EGL_NO_SURFACE:Ljavax/microedition/khronos/egl/EGLSurface;

    iput-object v2, p0, Lcom/adobe/air/FlashEGL10;->mEglSurface:Ljavax/microedition/khronos/egl/EGLSurface;

    .line 819
    if-eq v0, v7, :cond_0

    .line 822
    :cond_0
    sget-object v2, Ljavax/microedition/khronos/egl/EGL10;->EGL_NO_SURFACE:Ljavax/microedition/khronos/egl/EGLSurface;

    iput-object v2, p0, Lcom/adobe/air/FlashEGL10;->mEglWindowSurface:Ljavax/microedition/khronos/egl/EGLSurface;

    .line 823
    iget-object v2, p0, Lcom/adobe/air/FlashEGL10;->mEgl:Ljavax/microedition/khronos/egl/EGL10;

    iget-object v3, p0, Lcom/adobe/air/FlashEGL10;->mEglDisplay:Ljavax/microedition/khronos/egl/EGLDisplay;

    sget-object v4, Ljavax/microedition/khronos/egl/EGL10;->EGL_NO_SURFACE:Ljavax/microedition/khronos/egl/EGLSurface;

    sget-object v5, Ljavax/microedition/khronos/egl/EGL10;->EGL_NO_SURFACE:Ljavax/microedition/khronos/egl/EGLSurface;

    sget-object v6, Ljavax/microedition/khronos/egl/EGL10;->EGL_NO_CONTEXT:Ljavax/microedition/khronos/egl/EGLContext;

    invoke-interface {v2, v3, v4, v5, v6}, Ljavax/microedition/khronos/egl/EGL10;->eglMakeCurrent(Ljavax/microedition/khronos/egl/EGLDisplay;Ljavax/microedition/khronos/egl/EGLSurface;Ljavax/microedition/khronos/egl/EGLSurface;Ljavax/microedition/khronos/egl/EGLContext;)Z

    .line 824
    iget-object v2, p0, Lcom/adobe/air/FlashEGL10;->mEgl:Ljavax/microedition/khronos/egl/EGL10;

    invoke-interface {v2}, Ljavax/microedition/khronos/egl/EGL10;->eglGetError()I

    move-result v0

    .line 825
    if-eq v0, v7, :cond_1

    .line 830
    .end local v0    # "_error":I
    :cond_1
    iget-object v2, p0, Lcom/adobe/air/FlashEGL10;->mEglPbufferSurface:Ljavax/microedition/khronos/egl/EGLSurface;

    sget-object v3, Ljavax/microedition/khronos/egl/EGL10;->EGL_NO_SURFACE:Ljavax/microedition/khronos/egl/EGLSurface;

    if-eq v2, v3, :cond_2

    iget-object v2, p0, Lcom/adobe/air/FlashEGL10;->mEglContext:Ljavax/microedition/khronos/egl/EGLContext;

    sget-object v3, Ljavax/microedition/khronos/egl/EGL10;->EGL_NO_CONTEXT:Ljavax/microedition/khronos/egl/EGLContext;

    if-eq v2, v3, :cond_2

    .line 832
    iget-object v2, p0, Lcom/adobe/air/FlashEGL10;->mEglPbufferSurface:Ljavax/microedition/khronos/egl/EGLSurface;

    iput-object v2, p0, Lcom/adobe/air/FlashEGL10;->mEglSurface:Ljavax/microedition/khronos/egl/EGLSurface;

    .line 833
    iget-object v2, p0, Lcom/adobe/air/FlashEGL10;->mEgl:Ljavax/microedition/khronos/egl/EGL10;

    iget-object v3, p0, Lcom/adobe/air/FlashEGL10;->mEglDisplay:Ljavax/microedition/khronos/egl/EGLDisplay;

    iget-object v4, p0, Lcom/adobe/air/FlashEGL10;->mEglSurface:Ljavax/microedition/khronos/egl/EGLSurface;

    iget-object v5, p0, Lcom/adobe/air/FlashEGL10;->mEglSurface:Ljavax/microedition/khronos/egl/EGLSurface;

    iget-object v6, p0, Lcom/adobe/air/FlashEGL10;->mEglContext:Ljavax/microedition/khronos/egl/EGLContext;

    invoke-interface {v2, v3, v4, v5, v6}, Ljavax/microedition/khronos/egl/EGL10;->eglMakeCurrent(Ljavax/microedition/khronos/egl/EGLDisplay;Ljavax/microedition/khronos/egl/EGLSurface;Ljavax/microedition/khronos/egl/EGLSurface;Ljavax/microedition/khronos/egl/EGLContext;)Z

    .line 834
    iget-object v2, p0, Lcom/adobe/air/FlashEGL10;->mEgl:Ljavax/microedition/khronos/egl/EGL10;

    invoke-interface {v2}, Ljavax/microedition/khronos/egl/EGL10;->eglGetError()I

    move-result v0

    .line 835
    .restart local v0    # "_error":I
    if-eq v0, v7, :cond_2

    .line 839
    .end local v0    # "_error":I
    :cond_2
    const/4 v2, 0x1

    iput-boolean v2, p0, Lcom/adobe/air/FlashEGL10;->mIsGPUOOM:Z

    .line 842
    :cond_3
    return v1
.end method


# virtual methods
.method public ChooseConfig(Ljavax/microedition/khronos/egl/EGLDisplay;[I[Ljavax/microedition/khronos/egl/EGLConfig;I[I)Z
    .locals 15
    .param p1, "display"    # Ljavax/microedition/khronos/egl/EGLDisplay;
    .param p2, "attrs"    # [I
    .param p3, "configs"    # [Ljavax/microedition/khronos/egl/EGLConfig;
    .param p4, "configsLen"    # I
    .param p5, "numConfig"    # [I

    .prologue
    .line 132
    invoke-virtual {p0}, Lcom/adobe/air/FlashEGL10;->IsEmulator()Z

    move-result v1

    if-nez v1, :cond_0

    .line 133
    iget-object v1, p0, Lcom/adobe/air/FlashEGL10;->mEgl:Ljavax/microedition/khronos/egl/EGL10;

    move-object/from16 v2, p1

    move-object/from16 v3, p2

    move-object/from16 v4, p3

    move/from16 v5, p4

    move-object/from16 v6, p5

    invoke-interface/range {v1 .. v6}, Ljavax/microedition/khronos/egl/EGL10;->eglChooseConfig(Ljavax/microedition/khronos/egl/EGLDisplay;[I[Ljavax/microedition/khronos/egl/EGLConfig;I[I)Z

    move-result v1

    .line 181
    :goto_0
    return v1

    .line 137
    :cond_0
    const/4 v1, 0x1

    new-array v14, v1, [I

    .line 138
    .local v14, "numConf":[I
    iget-object v1, p0, Lcom/adobe/air/FlashEGL10;->mEgl:Ljavax/microedition/khronos/egl/EGL10;

    const/4 v2, 0x0

    const/4 v3, 0x0

    move-object/from16 v0, p1

    invoke-interface {v1, v0, v2, v3, v14}, Ljavax/microedition/khronos/egl/EGL10;->eglGetConfigs(Ljavax/microedition/khronos/egl/EGLDisplay;[Ljavax/microedition/khronos/egl/EGLConfig;I[I)Z

    .line 139
    const/4 v1, 0x0

    aget v10, v14, v1

    .line 142
    .local v10, "configurations":I
    new-array v9, v10, [Ljavax/microedition/khronos/egl/EGLConfig;

    .line 143
    .local v9, "conf":[Ljavax/microedition/khronos/egl/EGLConfig;
    iget-object v1, p0, Lcom/adobe/air/FlashEGL10;->mEgl:Ljavax/microedition/khronos/egl/EGL10;

    move-object/from16 v0, p1

    invoke-interface {v1, v0, v9, v10, v14}, Ljavax/microedition/khronos/egl/EGL10;->eglGetConfigs(Ljavax/microedition/khronos/egl/EGLDisplay;[Ljavax/microedition/khronos/egl/EGLConfig;I[I)Z

    .line 145
    const/4 v11, 0x0

    .line 146
    .local v11, "count":I
    move-object/from16 v0, p2

    array-length v8, v0

    .line 147
    .local v8, "attrsLen":I
    move-object/from16 v0, p2

    array-length v1, v0

    rem-int/lit8 v1, v1, 0x2

    if-eqz v1, :cond_1

    .line 148
    move-object/from16 v0, p2

    array-length v1, v0

    add-int/lit8 v8, v1, -0x1

    .line 150
    :cond_1
    const/4 v12, 0x0

    .local v12, "index":I
    :goto_1
    if-ge v12, v10, :cond_6

    .line 152
    const/4 v13, 0x0

    .line 153
    .local v13, "len":I
    :goto_2
    if-ge v13, v8, :cond_3

    .line 155
    add-int/lit8 v1, v13, 0x1

    aget v1, p2, v1

    const/4 v2, -0x1

    if-eq v1, v2, :cond_2

    .line 157
    const/4 v1, 0x1

    new-array v7, v1, [I

    .line 158
    .local v7, "attribVal":[I
    iget-object v1, p0, Lcom/adobe/air/FlashEGL10;->mEgl:Ljavax/microedition/khronos/egl/EGL10;

    aget-object v2, v9, v12

    aget v3, p2, v13

    move-object/from16 v0, p1

    invoke-interface {v1, v0, v2, v3, v7}, Ljavax/microedition/khronos/egl/EGL10;->eglGetConfigAttrib(Ljavax/microedition/khronos/egl/EGLDisplay;Ljavax/microedition/khronos/egl/EGLConfig;I[I)Z

    .line 161
    const/4 v1, 0x0

    aget v1, v7, v1

    add-int/lit8 v2, v13, 0x1

    aget v2, p2, v2

    and-int/2addr v1, v2

    add-int/lit8 v2, v13, 0x1

    aget v2, p2, v2

    if-ne v1, v2, :cond_3

    .line 153
    .end local v7    # "attribVal":[I
    :cond_2
    add-int/lit8 v13, v13, 0x2

    goto :goto_2

    .line 169
    :cond_3
    if-ne v13, v8, :cond_5

    .line 171
    if-eqz p3, :cond_4

    move/from16 v0, p4

    if-ge v11, v0, :cond_4

    .line 173
    aget-object v1, v9, v12

    aput-object v1, p3, v11

    .line 175
    :cond_4
    add-int/lit8 v11, v11, 0x1

    .line 150
    :cond_5
    add-int/lit8 v12, v12, 0x1

    goto :goto_1

    .line 180
    .end local v13    # "len":I
    :cond_6
    const/4 v1, 0x0

    aput v11, p5, v1

    .line 181
    const/4 v1, 0x1

    goto :goto_0
.end method

.method public CreateDummySurfaceAndContext()I
    .locals 15

    .prologue
    .line 319
    iget-object v0, p0, Lcom/adobe/air/FlashEGL10;->mEglDisplay:Ljavax/microedition/khronos/egl/EGLDisplay;

    sget-object v1, Ljavax/microedition/khronos/egl/EGL10;->EGL_NO_DISPLAY:Ljavax/microedition/khronos/egl/EGLDisplay;

    if-ne v0, v1, :cond_0

    .line 322
    const/16 v0, 0x3008

    .line 460
    :goto_0
    return v0

    .line 326
    :cond_0
    iget-object v0, p0, Lcom/adobe/air/FlashEGL10;->mEglContext:Ljavax/microedition/khronos/egl/EGLContext;

    sget-object v1, Ljavax/microedition/khronos/egl/EGL10;->EGL_NO_CONTEXT:Ljavax/microedition/khronos/egl/EGLContext;

    if-eq v0, v1, :cond_3

    .line 328
    iget-object v0, p0, Lcom/adobe/air/FlashEGL10;->mEglWindowSurface:Ljavax/microedition/khronos/egl/EGLSurface;

    sget-object v1, Ljavax/microedition/khronos/egl/EGL10;->EGL_NO_SURFACE:Ljavax/microedition/khronos/egl/EGLSurface;

    if-eq v0, v1, :cond_1

    .line 330
    iget-object v0, p0, Lcom/adobe/air/FlashEGL10;->mEgl:Ljavax/microedition/khronos/egl/EGL10;

    iget-object v1, p0, Lcom/adobe/air/FlashEGL10;->mEglDisplay:Ljavax/microedition/khronos/egl/EGLDisplay;

    iget-object v2, p0, Lcom/adobe/air/FlashEGL10;->mEglWindowSurface:Ljavax/microedition/khronos/egl/EGLSurface;

    iget-object v4, p0, Lcom/adobe/air/FlashEGL10;->mEglWindowSurface:Ljavax/microedition/khronos/egl/EGLSurface;

    iget-object v14, p0, Lcom/adobe/air/FlashEGL10;->mEglContext:Ljavax/microedition/khronos/egl/EGLContext;

    invoke-interface {v0, v1, v2, v4, v14}, Ljavax/microedition/khronos/egl/EGL10;->eglMakeCurrent(Ljavax/microedition/khronos/egl/EGLDisplay;Ljavax/microedition/khronos/egl/EGLSurface;Ljavax/microedition/khronos/egl/EGLSurface;Ljavax/microedition/khronos/egl/EGLContext;)Z

    .line 332
    const/16 v0, 0x3000

    goto :goto_0

    .line 334
    :cond_1
    iget-object v0, p0, Lcom/adobe/air/FlashEGL10;->mEglPbufferSurface:Ljavax/microedition/khronos/egl/EGLSurface;

    sget-object v1, Ljavax/microedition/khronos/egl/EGL10;->EGL_NO_SURFACE:Ljavax/microedition/khronos/egl/EGLSurface;

    if-eq v0, v1, :cond_2

    .line 336
    iget-object v0, p0, Lcom/adobe/air/FlashEGL10;->mEgl:Ljavax/microedition/khronos/egl/EGL10;

    iget-object v1, p0, Lcom/adobe/air/FlashEGL10;->mEglDisplay:Ljavax/microedition/khronos/egl/EGLDisplay;

    iget-object v2, p0, Lcom/adobe/air/FlashEGL10;->mEglPbufferSurface:Ljavax/microedition/khronos/egl/EGLSurface;

    iget-object v4, p0, Lcom/adobe/air/FlashEGL10;->mEglPbufferSurface:Ljavax/microedition/khronos/egl/EGLSurface;

    iget-object v14, p0, Lcom/adobe/air/FlashEGL10;->mEglContext:Ljavax/microedition/khronos/egl/EGLContext;

    invoke-interface {v0, v1, v2, v4, v14}, Ljavax/microedition/khronos/egl/EGL10;->eglMakeCurrent(Ljavax/microedition/khronos/egl/EGLDisplay;Ljavax/microedition/khronos/egl/EGLSurface;Ljavax/microedition/khronos/egl/EGLSurface;Ljavax/microedition/khronos/egl/EGLContext;)Z

    .line 338
    const/16 v0, 0x3000

    goto :goto_0

    .line 340
    :cond_2
    iget-object v0, p0, Lcom/adobe/air/FlashEGL10;->mEgl:Ljavax/microedition/khronos/egl/EGL10;

    iget-object v1, p0, Lcom/adobe/air/FlashEGL10;->mEglDisplay:Ljavax/microedition/khronos/egl/EGLDisplay;

    sget-object v2, Ljavax/microedition/khronos/egl/EGL10;->EGL_NO_SURFACE:Ljavax/microedition/khronos/egl/EGLSurface;

    sget-object v4, Ljavax/microedition/khronos/egl/EGL10;->EGL_NO_SURFACE:Ljavax/microedition/khronos/egl/EGLSurface;

    sget-object v14, Ljavax/microedition/khronos/egl/EGL10;->EGL_NO_CONTEXT:Ljavax/microedition/khronos/egl/EGLContext;

    invoke-interface {v0, v1, v2, v4, v14}, Ljavax/microedition/khronos/egl/EGL10;->eglMakeCurrent(Ljavax/microedition/khronos/egl/EGLDisplay;Ljavax/microedition/khronos/egl/EGLSurface;Ljavax/microedition/khronos/egl/EGLSurface;Ljavax/microedition/khronos/egl/EGLContext;)Z

    .line 341
    iget-object v0, p0, Lcom/adobe/air/FlashEGL10;->mEgl:Ljavax/microedition/khronos/egl/EGL10;

    iget-object v1, p0, Lcom/adobe/air/FlashEGL10;->mEglDisplay:Ljavax/microedition/khronos/egl/EGLDisplay;

    iget-object v2, p0, Lcom/adobe/air/FlashEGL10;->mEglContext:Ljavax/microedition/khronos/egl/EGLContext;

    invoke-interface {v0, v1, v2}, Ljavax/microedition/khronos/egl/EGL10;->eglDestroyContext(Ljavax/microedition/khronos/egl/EGLDisplay;Ljavax/microedition/khronos/egl/EGLContext;)Z

    .line 342
    sget-object v0, Ljavax/microedition/khronos/egl/EGL10;->EGL_NO_CONTEXT:Ljavax/microedition/khronos/egl/EGLContext;

    iput-object v0, p0, Lcom/adobe/air/FlashEGL10;->mEglContext:Ljavax/microedition/khronos/egl/EGLContext;

    .line 346
    :cond_3
    const/4 v0, 0x1

    new-array v5, v0, [I

    .line 347
    .local v5, "num_config":[I
    const/4 v0, 0x1

    new-array v3, v0, [Ljavax/microedition/khronos/egl/EGLConfig;

    .line 348
    .local v3, "configList":[Ljavax/microedition/khronos/egl/EGLConfig;
    sget-object v0, Lcom/adobe/air/FlashEGL10;->cfgAttrs:[I

    const/4 v1, 0x1

    const/4 v2, 0x1

    aput v2, v0, v1

    .line 349
    iget-object v1, p0, Lcom/adobe/air/FlashEGL10;->mEglDisplay:Ljavax/microedition/khronos/egl/EGLDisplay;

    sget-object v2, Lcom/adobe/air/FlashEGL10;->cfgAttrs:[I

    const/4 v4, 0x1

    move-object v0, p0

    invoke-virtual/range {v0 .. v5}, Lcom/adobe/air/FlashEGL10;->ChooseConfig(Ljavax/microedition/khronos/egl/EGLDisplay;[I[Ljavax/microedition/khronos/egl/EGLConfig;I[I)Z

    .line 350
    sget-object v0, Lcom/adobe/air/FlashEGL10;->cfgAttrs:[I

    const/4 v1, 0x1

    const/4 v2, -0x1

    aput v2, v0, v1

    .line 352
    const/4 v0, 0x0

    aget v10, v5, v0

    .line 353
    .local v10, "numPbufferConfigs":I
    if-nez v10, :cond_4

    .line 355
    const/16 v0, 0x3006

    goto :goto_0

    .line 361
    :cond_4
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x12

    if-lt v0, v1, :cond_5

    const/4 v13, 0x1

    .line 370
    .local v13, "tryES3":Z
    :goto_1
    const/4 v0, 0x3

    new-array v7, v0, [I

    const/4 v0, 0x0

    sget v1, Lcom/adobe/air/FlashEGL10;->EGL_CONTEXT_CLIENT_VERSION:I

    aput v1, v7, v0

    const/4 v0, 0x1

    const/4 v1, 0x2

    aput v1, v7, v0

    const/4 v0, 0x2

    const/16 v1, 0x3038

    aput v1, v7, v0

    .line 371
    .local v7, "attrib_list":[I
    const/4 v6, 0x0

    .line 372
    .local v6, "ES3available":Z
    if-eqz v13, :cond_b

    .line 374
    iget-object v0, p0, Lcom/adobe/air/FlashEGL10;->mEgl:Ljavax/microedition/khronos/egl/EGL10;

    iget-object v1, p0, Lcom/adobe/air/FlashEGL10;->mEglDisplay:Ljavax/microedition/khronos/egl/EGLDisplay;

    const/4 v2, 0x0

    aget-object v2, v3, v2

    sget-object v4, Ljavax/microedition/khronos/egl/EGL10;->EGL_NO_CONTEXT:Ljavax/microedition/khronos/egl/EGLContext;

    invoke-interface {v0, v1, v2, v4, v7}, Ljavax/microedition/khronos/egl/EGL10;->eglCreateContext(Ljavax/microedition/khronos/egl/EGLDisplay;Ljavax/microedition/khronos/egl/EGLConfig;Ljavax/microedition/khronos/egl/EGLContext;[I)Ljavax/microedition/khronos/egl/EGLContext;

    move-result-object v0

    iput-object v0, p0, Lcom/adobe/air/FlashEGL10;->mEglContext:Ljavax/microedition/khronos/egl/EGLContext;

    .line 375
    iget-object v0, p0, Lcom/adobe/air/FlashEGL10;->mEglContext:Ljavax/microedition/khronos/egl/EGLContext;

    sget-object v1, Ljavax/microedition/khronos/egl/EGL10;->EGL_NO_CONTEXT:Ljavax/microedition/khronos/egl/EGLContext;

    if-ne v0, v1, :cond_6

    .line 378
    const/16 v0, 0x3006

    goto/16 :goto_0

    .line 361
    .end local v6    # "ES3available":Z
    .end local v7    # "attrib_list":[I
    .end local v13    # "tryES3":Z
    :cond_5
    const/4 v13, 0x0

    goto :goto_1

    .line 380
    .restart local v6    # "ES3available":Z
    .restart local v7    # "attrib_list":[I
    .restart local v13    # "tryES3":Z
    :cond_6
    const-string v0, "After creating dummy context for checking gl version"

    invoke-direct {p0, v0}, Lcom/adobe/air/FlashEGL10;->checkEglError(Ljava/lang/String;)I

    .line 381
    iget-object v0, p0, Lcom/adobe/air/FlashEGL10;->mEgl:Ljavax/microedition/khronos/egl/EGL10;

    iget-object v1, p0, Lcom/adobe/air/FlashEGL10;->mEglDisplay:Ljavax/microedition/khronos/egl/EGLDisplay;

    const/4 v2, 0x0

    aget-object v2, v3, v2

    sget-object v4, Lcom/adobe/air/FlashEGL10;->fbPBufferSurfaceAttrs:[I

    invoke-interface {v0, v1, v2, v4}, Ljavax/microedition/khronos/egl/EGL10;->eglCreatePbufferSurface(Ljavax/microedition/khronos/egl/EGLDisplay;Ljavax/microedition/khronos/egl/EGLConfig;[I)Ljavax/microedition/khronos/egl/EGLSurface;

    move-result-object v8

    .line 382
    .local v8, "mEglPbufferSurface":Ljavax/microedition/khronos/egl/EGLSurface;
    const-string v0, "After eglCreatePbufferSurface for checking gl version"

    invoke-direct {p0, v0}, Lcom/adobe/air/FlashEGL10;->checkEglError(Ljava/lang/String;)I

    .line 383
    sget-object v0, Ljavax/microedition/khronos/egl/EGL10;->EGL_NO_SURFACE:Ljavax/microedition/khronos/egl/EGLSurface;

    if-ne v8, v0, :cond_7

    .line 386
    const/16 v0, 0x3006

    goto/16 :goto_0

    .line 388
    :cond_7
    iget-object v0, p0, Lcom/adobe/air/FlashEGL10;->mEgl:Ljavax/microedition/khronos/egl/EGL10;

    iget-object v1, p0, Lcom/adobe/air/FlashEGL10;->mEglDisplay:Ljavax/microedition/khronos/egl/EGLDisplay;

    iget-object v2, p0, Lcom/adobe/air/FlashEGL10;->mEglContext:Ljavax/microedition/khronos/egl/EGLContext;

    invoke-interface {v0, v1, v8, v8, v2}, Ljavax/microedition/khronos/egl/EGL10;->eglMakeCurrent(Ljavax/microedition/khronos/egl/EGLDisplay;Ljavax/microedition/khronos/egl/EGLSurface;Ljavax/microedition/khronos/egl/EGLSurface;Ljavax/microedition/khronos/egl/EGLContext;)Z

    .line 389
    const-string v0, "After eglMakeCurrent for checking gl version"

    invoke-direct {p0, v0}, Lcom/adobe/air/FlashEGL10;->checkEglError(Ljava/lang/String;)I

    .line 390
    const/16 v0, 0x1f02

    invoke-static {v0}, Landroid/opengl/GLES10;->glGetString(I)Ljava/lang/String;

    move-result-object v12

    .line 391
    .local v12, "strGLVersion":Ljava/lang/String;
    const/4 v9, 0x0

    .line 392
    .local v9, "mOpenGLVersionMajor":I
    if-eqz v12, :cond_9

    .line 393
    new-instance v11, Ljava/util/Scanner;

    invoke-direct {v11, v12}, Ljava/util/Scanner;-><init>(Ljava/lang/String;)V

    .line 394
    .local v11, "scanner":Ljava/util/Scanner;
    const-string v0, "[^\\w\']+"

    invoke-virtual {v11, v0}, Ljava/util/Scanner;->useDelimiter(Ljava/lang/String;)Ljava/util/Scanner;

    .line 396
    :cond_8
    :goto_2
    invoke-virtual {v11}, Ljava/util/Scanner;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_9

    .line 397
    invoke-virtual {v11}, Ljava/util/Scanner;->hasNextInt()Z

    move-result v0

    if-eqz v0, :cond_d

    .line 398
    invoke-virtual {v11}, Ljava/util/Scanner;->nextInt()I

    move-result v9

    .line 406
    .end local v11    # "scanner":Ljava/util/Scanner;
    :cond_9
    const/4 v0, 0x3

    if-lt v9, v0, :cond_a

    .line 409
    const/4 v6, 0x1

    .line 412
    :cond_a
    iget-object v0, p0, Lcom/adobe/air/FlashEGL10;->mEgl:Ljavax/microedition/khronos/egl/EGL10;

    iget-object v1, p0, Lcom/adobe/air/FlashEGL10;->mEglDisplay:Ljavax/microedition/khronos/egl/EGLDisplay;

    sget-object v2, Ljavax/microedition/khronos/egl/EGL10;->EGL_NO_SURFACE:Ljavax/microedition/khronos/egl/EGLSurface;

    sget-object v4, Ljavax/microedition/khronos/egl/EGL10;->EGL_NO_SURFACE:Ljavax/microedition/khronos/egl/EGLSurface;

    sget-object v14, Ljavax/microedition/khronos/egl/EGL10;->EGL_NO_CONTEXT:Ljavax/microedition/khronos/egl/EGLContext;

    invoke-interface {v0, v1, v2, v4, v14}, Ljavax/microedition/khronos/egl/EGL10;->eglMakeCurrent(Ljavax/microedition/khronos/egl/EGLDisplay;Ljavax/microedition/khronos/egl/EGLSurface;Ljavax/microedition/khronos/egl/EGLSurface;Ljavax/microedition/khronos/egl/EGLContext;)Z

    .line 414
    iget-object v0, p0, Lcom/adobe/air/FlashEGL10;->mEgl:Ljavax/microedition/khronos/egl/EGL10;

    iget-object v1, p0, Lcom/adobe/air/FlashEGL10;->mEglDisplay:Ljavax/microedition/khronos/egl/EGLDisplay;

    invoke-interface {v0, v1, v8}, Ljavax/microedition/khronos/egl/EGL10;->eglDestroySurface(Ljavax/microedition/khronos/egl/EGLDisplay;Ljavax/microedition/khronos/egl/EGLSurface;)Z

    .line 415
    iget-object v0, p0, Lcom/adobe/air/FlashEGL10;->mEgl:Ljavax/microedition/khronos/egl/EGL10;

    iget-object v1, p0, Lcom/adobe/air/FlashEGL10;->mEglDisplay:Ljavax/microedition/khronos/egl/EGLDisplay;

    iget-object v2, p0, Lcom/adobe/air/FlashEGL10;->mEglContext:Ljavax/microedition/khronos/egl/EGLContext;

    invoke-interface {v0, v1, v2}, Ljavax/microedition/khronos/egl/EGL10;->eglDestroyContext(Ljavax/microedition/khronos/egl/EGLDisplay;Ljavax/microedition/khronos/egl/EGLContext;)Z

    .line 416
    sget-object v0, Ljavax/microedition/khronos/egl/EGL10;->EGL_NO_CONTEXT:Ljavax/microedition/khronos/egl/EGLContext;

    iput-object v0, p0, Lcom/adobe/air/FlashEGL10;->mEglContext:Ljavax/microedition/khronos/egl/EGLContext;

    .line 419
    .end local v8    # "mEglPbufferSurface":Ljavax/microedition/khronos/egl/EGLSurface;
    .end local v9    # "mOpenGLVersionMajor":I
    .end local v12    # "strGLVersion":Ljava/lang/String;
    :cond_b
    if-eqz v6, :cond_c

    .line 422
    const/4 v0, 0x1

    const/4 v1, 0x3

    aput v1, v7, v0

    .line 423
    const-string v0, "Before eglCreateContext es3"

    invoke-direct {p0, v0}, Lcom/adobe/air/FlashEGL10;->checkEglError(Ljava/lang/String;)I

    .line 425
    iget-object v0, p0, Lcom/adobe/air/FlashEGL10;->mEgl:Ljavax/microedition/khronos/egl/EGL10;

    iget-object v1, p0, Lcom/adobe/air/FlashEGL10;->mEglDisplay:Ljavax/microedition/khronos/egl/EGLDisplay;

    const/4 v2, 0x0

    aget-object v2, v3, v2

    sget-object v4, Ljavax/microedition/khronos/egl/EGL10;->EGL_NO_CONTEXT:Ljavax/microedition/khronos/egl/EGLContext;

    invoke-interface {v0, v1, v2, v4, v7}, Ljavax/microedition/khronos/egl/EGL10;->eglCreateContext(Ljavax/microedition/khronos/egl/EGLDisplay;Ljavax/microedition/khronos/egl/EGLConfig;Ljavax/microedition/khronos/egl/EGLContext;[I)Ljavax/microedition/khronos/egl/EGLContext;

    move-result-object v0

    iput-object v0, p0, Lcom/adobe/air/FlashEGL10;->mEglContext:Ljavax/microedition/khronos/egl/EGLContext;

    .line 426
    const-string v0, "After eglCreateContext es3"

    invoke-direct {p0, v0}, Lcom/adobe/air/FlashEGL10;->checkEglError(Ljava/lang/String;)I

    .line 427
    iget-object v0, p0, Lcom/adobe/air/FlashEGL10;->mEglContext:Ljavax/microedition/khronos/egl/EGLContext;

    sget-object v1, Ljavax/microedition/khronos/egl/EGL10;->EGL_NO_CONTEXT:Ljavax/microedition/khronos/egl/EGLContext;

    if-eq v0, v1, :cond_c

    .line 428
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/adobe/air/FlashEGL10;->mIsES3Device:Z

    .line 432
    :cond_c
    iget-object v0, p0, Lcom/adobe/air/FlashEGL10;->mEglContext:Ljavax/microedition/khronos/egl/EGLContext;

    sget-object v1, Ljavax/microedition/khronos/egl/EGL10;->EGL_NO_CONTEXT:Ljavax/microedition/khronos/egl/EGLContext;

    if-ne v0, v1, :cond_e

    .line 434
    const/4 v0, 0x1

    const/4 v1, 0x2

    aput v1, v7, v0

    .line 435
    const-string v0, "Before eglCreateContext es2"

    invoke-direct {p0, v0}, Lcom/adobe/air/FlashEGL10;->checkEglError(Ljava/lang/String;)I

    .line 436
    iget-object v0, p0, Lcom/adobe/air/FlashEGL10;->mEgl:Ljavax/microedition/khronos/egl/EGL10;

    iget-object v1, p0, Lcom/adobe/air/FlashEGL10;->mEglDisplay:Ljavax/microedition/khronos/egl/EGLDisplay;

    const/4 v2, 0x0

    aget-object v2, v3, v2

    sget-object v4, Ljavax/microedition/khronos/egl/EGL10;->EGL_NO_CONTEXT:Ljavax/microedition/khronos/egl/EGLContext;

    invoke-interface {v0, v1, v2, v4, v7}, Ljavax/microedition/khronos/egl/EGL10;->eglCreateContext(Ljavax/microedition/khronos/egl/EGLDisplay;Ljavax/microedition/khronos/egl/EGLConfig;Ljavax/microedition/khronos/egl/EGLContext;[I)Ljavax/microedition/khronos/egl/EGLContext;

    move-result-object v0

    iput-object v0, p0, Lcom/adobe/air/FlashEGL10;->mEglContext:Ljavax/microedition/khronos/egl/EGLContext;

    .line 437
    const-string v0, "After eglCreateContext es2"

    invoke-direct {p0, v0}, Lcom/adobe/air/FlashEGL10;->checkEglError(Ljava/lang/String;)I

    .line 438
    iget-object v0, p0, Lcom/adobe/air/FlashEGL10;->mEglContext:Ljavax/microedition/khronos/egl/EGLContext;

    sget-object v1, Ljavax/microedition/khronos/egl/EGL10;->EGL_NO_CONTEXT:Ljavax/microedition/khronos/egl/EGLContext;

    if-ne v0, v1, :cond_e

    .line 441
    const/16 v0, 0x3006

    goto/16 :goto_0

    .line 401
    .restart local v8    # "mEglPbufferSurface":Ljavax/microedition/khronos/egl/EGLSurface;
    .restart local v9    # "mOpenGLVersionMajor":I
    .restart local v11    # "scanner":Ljava/util/Scanner;
    .restart local v12    # "strGLVersion":Ljava/lang/String;
    :cond_d
    invoke-virtual {v11}, Ljava/util/Scanner;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_8

    .line 402
    invoke-virtual {v11}, Ljava/util/Scanner;->next()Ljava/lang/String;

    goto/16 :goto_2

    .line 445
    .end local v8    # "mEglPbufferSurface":Ljavax/microedition/khronos/egl/EGLSurface;
    .end local v9    # "mOpenGLVersionMajor":I
    .end local v11    # "scanner":Ljava/util/Scanner;
    .end local v12    # "strGLVersion":Ljava/lang/String;
    :cond_e
    const-string v0, "Before eglCreatePbufferSurface"

    invoke-direct {p0, v0}, Lcom/adobe/air/FlashEGL10;->checkEglError(Ljava/lang/String;)I

    .line 446
    iget-object v0, p0, Lcom/adobe/air/FlashEGL10;->mEgl:Ljavax/microedition/khronos/egl/EGL10;

    iget-object v1, p0, Lcom/adobe/air/FlashEGL10;->mEglDisplay:Ljavax/microedition/khronos/egl/EGLDisplay;

    const/4 v2, 0x0

    aget-object v2, v3, v2

    sget-object v4, Lcom/adobe/air/FlashEGL10;->fbPBufferSurfaceAttrs:[I

    invoke-interface {v0, v1, v2, v4}, Ljavax/microedition/khronos/egl/EGL10;->eglCreatePbufferSurface(Ljavax/microedition/khronos/egl/EGLDisplay;Ljavax/microedition/khronos/egl/EGLConfig;[I)Ljavax/microedition/khronos/egl/EGLSurface;

    move-result-object v0

    iput-object v0, p0, Lcom/adobe/air/FlashEGL10;->mEglPbufferSurface:Ljavax/microedition/khronos/egl/EGLSurface;

    .line 447
    const-string v0, "After eglCreatePbufferSurface"

    invoke-direct {p0, v0}, Lcom/adobe/air/FlashEGL10;->checkEglError(Ljava/lang/String;)I

    .line 449
    iget-object v0, p0, Lcom/adobe/air/FlashEGL10;->mEglPbufferSurface:Ljavax/microedition/khronos/egl/EGLSurface;

    sget-object v1, Ljavax/microedition/khronos/egl/EGL10;->EGL_NO_SURFACE:Ljavax/microedition/khronos/egl/EGLSurface;

    if-ne v0, v1, :cond_f

    .line 452
    const/16 v0, 0x3006

    goto/16 :goto_0

    .line 455
    :cond_f
    const-string v0, "Before eglMakeCurrent"

    invoke-direct {p0, v0}, Lcom/adobe/air/FlashEGL10;->checkEglError(Ljava/lang/String;)I

    .line 456
    iget-object v0, p0, Lcom/adobe/air/FlashEGL10;->mEgl:Ljavax/microedition/khronos/egl/EGL10;

    iget-object v1, p0, Lcom/adobe/air/FlashEGL10;->mEglDisplay:Ljavax/microedition/khronos/egl/EGLDisplay;

    iget-object v2, p0, Lcom/adobe/air/FlashEGL10;->mEglPbufferSurface:Ljavax/microedition/khronos/egl/EGLSurface;

    iget-object v4, p0, Lcom/adobe/air/FlashEGL10;->mEglPbufferSurface:Ljavax/microedition/khronos/egl/EGLSurface;

    iget-object v14, p0, Lcom/adobe/air/FlashEGL10;->mEglContext:Ljavax/microedition/khronos/egl/EGLContext;

    invoke-interface {v0, v1, v2, v4, v14}, Ljavax/microedition/khronos/egl/EGL10;->eglMakeCurrent(Ljavax/microedition/khronos/egl/EGLDisplay;Ljavax/microedition/khronos/egl/EGLSurface;Ljavax/microedition/khronos/egl/EGLSurface;Ljavax/microedition/khronos/egl/EGLContext;)Z

    .line 457
    const-string v0, "After eglMakeCurrent"

    invoke-direct {p0, v0}, Lcom/adobe/air/FlashEGL10;->checkEglError(Ljava/lang/String;)I

    .line 460
    const/16 v0, 0x3000

    goto/16 :goto_0
.end method

.method public CreateGLContext(Z)I
    .locals 8
    .param p1, "replace"    # Z

    .prologue
    const/16 v5, 0x3000

    const/4 v3, 0x3

    const/4 v4, 0x2

    .line 523
    iget-object v6, p0, Lcom/adobe/air/FlashEGL10;->mEglConfig:Ljavax/microedition/khronos/egl/EGLConfig;

    if-nez v6, :cond_0

    .line 526
    const/16 v3, 0x3005

    .line 569
    :goto_0
    return v3

    .line 531
    :cond_0
    iget-object v6, p0, Lcom/adobe/air/FlashEGL10;->mEglContext:Ljavax/microedition/khronos/egl/EGLContext;

    sget-object v7, Ljavax/microedition/khronos/egl/EGL10;->EGL_NO_CONTEXT:Ljavax/microedition/khronos/egl/EGLContext;

    if-eq v6, v7, :cond_1

    if-nez p1, :cond_1

    move v3, v5

    .line 533
    goto :goto_0

    .line 539
    :cond_1
    iget-boolean v6, p0, Lcom/adobe/air/FlashEGL10;->mIsES3Device:Z

    if-eqz v6, :cond_2

    move v1, v3

    .line 540
    .local v1, "glVersion":I
    :goto_1
    new-array v0, v3, [I

    const/4 v3, 0x0

    sget v6, Lcom/adobe/air/FlashEGL10;->EGL_CONTEXT_CLIENT_VERSION:I

    aput v6, v0, v3

    const/4 v3, 0x1

    aput v1, v0, v3

    const/16 v3, 0x3038

    aput v3, v0, v4

    .line 542
    .local v0, "attrib_list":[I
    if-eqz p1, :cond_3

    .line 544
    iget-object v2, p0, Lcom/adobe/air/FlashEGL10;->mEglContext:Ljavax/microedition/khronos/egl/EGLContext;

    .line 545
    .local v2, "oldContext":Ljavax/microedition/khronos/egl/EGLContext;
    const-string v3, "Before eglCreateContext"

    invoke-direct {p0, v3}, Lcom/adobe/air/FlashEGL10;->checkEglError(Ljava/lang/String;)I

    .line 546
    iget-object v3, p0, Lcom/adobe/air/FlashEGL10;->mEgl:Ljavax/microedition/khronos/egl/EGL10;

    iget-object v4, p0, Lcom/adobe/air/FlashEGL10;->mEglDisplay:Ljavax/microedition/khronos/egl/EGLDisplay;

    iget-object v6, p0, Lcom/adobe/air/FlashEGL10;->mEglConfig:Ljavax/microedition/khronos/egl/EGLConfig;

    invoke-interface {v3, v4, v6, v2, v0}, Ljavax/microedition/khronos/egl/EGL10;->eglCreateContext(Ljavax/microedition/khronos/egl/EGLDisplay;Ljavax/microedition/khronos/egl/EGLConfig;Ljavax/microedition/khronos/egl/EGLContext;[I)Ljavax/microedition/khronos/egl/EGLContext;

    move-result-object v3

    iput-object v3, p0, Lcom/adobe/air/FlashEGL10;->mEglContext:Ljavax/microedition/khronos/egl/EGLContext;

    .line 547
    const-string v3, "After eglCreateContext"

    invoke-direct {p0, v3}, Lcom/adobe/air/FlashEGL10;->checkEglError(Ljava/lang/String;)I

    .line 548
    iget-object v3, p0, Lcom/adobe/air/FlashEGL10;->mEgl:Ljavax/microedition/khronos/egl/EGL10;

    iget-object v4, p0, Lcom/adobe/air/FlashEGL10;->mEglDisplay:Ljavax/microedition/khronos/egl/EGLDisplay;

    invoke-interface {v3, v4, v2}, Ljavax/microedition/khronos/egl/EGL10;->eglDestroyContext(Ljavax/microedition/khronos/egl/EGLDisplay;Ljavax/microedition/khronos/egl/EGLContext;)Z

    .line 549
    const-string v3, "After eglDestroyContext"

    invoke-direct {p0, v3}, Lcom/adobe/air/FlashEGL10;->checkEglError(Ljava/lang/String;)I

    .line 558
    .end local v2    # "oldContext":Ljavax/microedition/khronos/egl/EGLContext;
    :goto_2
    iget-object v3, p0, Lcom/adobe/air/FlashEGL10;->mEglContext:Ljavax/microedition/khronos/egl/EGLContext;

    sget-object v4, Ljavax/microedition/khronos/egl/EGL10;->EGL_NO_CONTEXT:Ljavax/microedition/khronos/egl/EGLContext;

    if-ne v3, v4, :cond_4

    .line 559
    const/16 v3, 0x3006

    goto :goto_0

    .end local v0    # "attrib_list":[I
    .end local v1    # "glVersion":I
    :cond_2
    move v1, v4

    .line 539
    goto :goto_1

    .line 553
    .restart local v0    # "attrib_list":[I
    .restart local v1    # "glVersion":I
    :cond_3
    const-string v3, "Before eglCreateContext"

    invoke-direct {p0, v3}, Lcom/adobe/air/FlashEGL10;->checkEglError(Ljava/lang/String;)I

    .line 554
    iget-object v3, p0, Lcom/adobe/air/FlashEGL10;->mEgl:Ljavax/microedition/khronos/egl/EGL10;

    iget-object v4, p0, Lcom/adobe/air/FlashEGL10;->mEglDisplay:Ljavax/microedition/khronos/egl/EGLDisplay;

    iget-object v6, p0, Lcom/adobe/air/FlashEGL10;->mEglConfig:Ljavax/microedition/khronos/egl/EGLConfig;

    sget-object v7, Ljavax/microedition/khronos/egl/EGL10;->EGL_NO_CONTEXT:Ljavax/microedition/khronos/egl/EGLContext;

    invoke-interface {v3, v4, v6, v7, v0}, Ljavax/microedition/khronos/egl/EGL10;->eglCreateContext(Ljavax/microedition/khronos/egl/EGLDisplay;Ljavax/microedition/khronos/egl/EGLConfig;Ljavax/microedition/khronos/egl/EGLContext;[I)Ljavax/microedition/khronos/egl/EGLContext;

    move-result-object v3

    iput-object v3, p0, Lcom/adobe/air/FlashEGL10;->mEglContext:Ljavax/microedition/khronos/egl/EGLContext;

    .line 555
    const-string v3, "After eglCreateContext"

    invoke-direct {p0, v3}, Lcom/adobe/air/FlashEGL10;->checkEglError(Ljava/lang/String;)I

    goto :goto_2

    .line 562
    :cond_4
    sget-object v3, Ljavax/microedition/khronos/egl/EGL10;->EGL_NO_SURFACE:Ljavax/microedition/khronos/egl/EGLSurface;

    iget-object v4, p0, Lcom/adobe/air/FlashEGL10;->mEglPbufferSurface:Ljavax/microedition/khronos/egl/EGLSurface;

    if-ne v3, v4, :cond_5

    .line 564
    const-string v3, "Before eglCreatePbufferSurface"

    invoke-direct {p0, v3}, Lcom/adobe/air/FlashEGL10;->checkEglError(Ljava/lang/String;)I

    .line 565
    iget-object v3, p0, Lcom/adobe/air/FlashEGL10;->mEgl:Ljavax/microedition/khronos/egl/EGL10;

    iget-object v4, p0, Lcom/adobe/air/FlashEGL10;->mEglDisplay:Ljavax/microedition/khronos/egl/EGLDisplay;

    iget-object v6, p0, Lcom/adobe/air/FlashEGL10;->mEglConfig:Ljavax/microedition/khronos/egl/EGLConfig;

    sget-object v7, Lcom/adobe/air/FlashEGL10;->fbPBufferSurfaceAttrs:[I

    invoke-interface {v3, v4, v6, v7}, Ljavax/microedition/khronos/egl/EGL10;->eglCreatePbufferSurface(Ljavax/microedition/khronos/egl/EGLDisplay;Ljavax/microedition/khronos/egl/EGLConfig;[I)Ljavax/microedition/khronos/egl/EGLSurface;

    move-result-object v3

    iput-object v3, p0, Lcom/adobe/air/FlashEGL10;->mEglPbufferSurface:Ljavax/microedition/khronos/egl/EGLSurface;

    .line 566
    const-string v3, "After eglCreatePbufferSurface"

    invoke-direct {p0, v3}, Lcom/adobe/air/FlashEGL10;->checkEglError(Ljava/lang/String;)I

    :cond_5
    move v3, v5

    .line 569
    goto/16 :goto_0
.end method

.method public CreateWindowSurface(Landroid/view/SurfaceView;I)I
    .locals 11
    .param p1, "view"    # Landroid/view/SurfaceView;
    .param p2, "swapPreserveBehavior"    # I

    .prologue
    .line 673
    iget-boolean v6, p0, Lcom/adobe/air/FlashEGL10;->mIsGPUOOM:Z

    if-eqz v6, :cond_1

    .line 674
    const/16 v1, 0x3003

    .line 757
    .end local p1    # "view":Landroid/view/SurfaceView;
    :cond_0
    :goto_0
    return v1

    .line 676
    .restart local p1    # "view":Landroid/view/SurfaceView;
    :cond_1
    instance-of v2, p1, Lcom/adobe/air/AIRWindowSurfaceView;

    .line 678
    .local v2, "isAIRWindowSurfaceView":Z
    instance-of v6, p1, Lcom/adobe/flashruntime/air/VideoViewAIR;

    if-nez v6, :cond_2

    instance-of v6, p1, Lcom/adobe/air/AIRStage3DSurfaceView;

    if-nez v6, :cond_2

    if-nez v2, :cond_2

    .line 683
    const/16 v1, 0x300d

    goto :goto_0

    .line 686
    :cond_2
    iget-object v6, p0, Lcom/adobe/air/FlashEGL10;->mEglWindowSurface:Ljavax/microedition/khronos/egl/EGLSurface;

    sget-object v7, Ljavax/microedition/khronos/egl/EGL10;->EGL_NO_SURFACE:Ljavax/microedition/khronos/egl/EGLSurface;

    if-eq v6, v7, :cond_3

    .line 689
    iget-object v6, p0, Lcom/adobe/air/FlashEGL10;->mEglWindowSurface:Ljavax/microedition/khronos/egl/EGLSurface;

    iput-object v6, p0, Lcom/adobe/air/FlashEGL10;->mEglSurface:Ljavax/microedition/khronos/egl/EGLSurface;

    .line 690
    invoke-virtual {p0}, Lcom/adobe/air/FlashEGL10;->MakeGLCurrent()I

    move-result v1

    goto :goto_0

    .line 694
    :cond_3
    const/4 v0, 0x1

    .line 695
    .local v0, "checkSwapPreserve":Z
    iget v6, p0, Lcom/adobe/air/FlashEGL10;->kSwapPreserveOn:I

    if-ne p2, v6, :cond_6

    .line 697
    const-string v6, "Before eglCreateWindowSurface"

    invoke-direct {p0, v6}, Lcom/adobe/air/FlashEGL10;->checkEglError(Ljava/lang/String;)I

    .line 698
    iget-object v6, p0, Lcom/adobe/air/FlashEGL10;->mEgl:Ljavax/microedition/khronos/egl/EGL10;

    iget-object v7, p0, Lcom/adobe/air/FlashEGL10;->mEglDisplay:Ljavax/microedition/khronos/egl/EGLDisplay;

    iget-object v8, p0, Lcom/adobe/air/FlashEGL10;->mEglConfig:Ljavax/microedition/khronos/egl/EGLConfig;

    invoke-virtual {p1}, Landroid/view/SurfaceView;->getHolder()Landroid/view/SurfaceHolder;

    move-result-object v9

    sget-object v10, Lcom/adobe/air/FlashEGL10;->fbWindowSurfaceOnAttrs:[I

    invoke-interface {v6, v7, v8, v9, v10}, Ljavax/microedition/khronos/egl/EGL10;->eglCreateWindowSurface(Ljavax/microedition/khronos/egl/EGLDisplay;Ljavax/microedition/khronos/egl/EGLConfig;Ljava/lang/Object;[I)Ljavax/microedition/khronos/egl/EGLSurface;

    move-result-object v6

    iput-object v6, p0, Lcom/adobe/air/FlashEGL10;->mEglWindowSurface:Ljavax/microedition/khronos/egl/EGLSurface;

    .line 699
    iget-object v6, p0, Lcom/adobe/air/FlashEGL10;->mEglWindowSurface:Ljavax/microedition/khronos/egl/EGLSurface;

    sget-object v7, Ljavax/microedition/khronos/egl/EGL10;->EGL_NO_SURFACE:Ljavax/microedition/khronos/egl/EGLSurface;

    if-ne v6, v7, :cond_4

    .line 700
    const-string v6, "After eglCreateWindowSurface"

    invoke-direct {p0, v6}, Lcom/adobe/air/FlashEGL10;->checkEglError(Ljava/lang/String;)I

    .line 701
    const/4 v0, 0x0

    .line 712
    :cond_4
    :goto_1
    iget-object v6, p0, Lcom/adobe/air/FlashEGL10;->mEglWindowSurface:Ljavax/microedition/khronos/egl/EGLSurface;

    sget-object v7, Ljavax/microedition/khronos/egl/EGL10;->EGL_NO_SURFACE:Ljavax/microedition/khronos/egl/EGLSurface;

    if-ne v6, v7, :cond_5

    .line 715
    const-string v6, "Before eglCreateWindowSurface"

    invoke-direct {p0, v6}, Lcom/adobe/air/FlashEGL10;->checkEglError(Ljava/lang/String;)I

    .line 716
    iget-object v6, p0, Lcom/adobe/air/FlashEGL10;->mEgl:Ljavax/microedition/khronos/egl/EGL10;

    iget-object v7, p0, Lcom/adobe/air/FlashEGL10;->mEglDisplay:Ljavax/microedition/khronos/egl/EGLDisplay;

    iget-object v8, p0, Lcom/adobe/air/FlashEGL10;->mEglConfig:Ljavax/microedition/khronos/egl/EGLConfig;

    invoke-virtual {p1}, Landroid/view/SurfaceView;->getHolder()Landroid/view/SurfaceHolder;

    move-result-object v9

    const/4 v10, 0x0

    invoke-interface {v6, v7, v8, v9, v10}, Ljavax/microedition/khronos/egl/EGL10;->eglCreateWindowSurface(Ljavax/microedition/khronos/egl/EGLDisplay;Ljavax/microedition/khronos/egl/EGLConfig;Ljava/lang/Object;[I)Ljavax/microedition/khronos/egl/EGLSurface;

    move-result-object v6

    iput-object v6, p0, Lcom/adobe/air/FlashEGL10;->mEglWindowSurface:Ljavax/microedition/khronos/egl/EGLSurface;

    .line 717
    const-string v6, "After eglCreateWindowSurface"

    invoke-direct {p0, v6}, Lcom/adobe/air/FlashEGL10;->checkEglError(Ljava/lang/String;)I

    move-result v1

    .line 718
    .local v1, "error":I
    const/16 v6, 0x3000

    if-ne v1, v6, :cond_0

    .line 722
    .end local v1    # "error":I
    :cond_5
    iget-object v6, p0, Lcom/adobe/air/FlashEGL10;->mEglWindowSurface:Ljavax/microedition/khronos/egl/EGLSurface;

    sget-object v7, Ljavax/microedition/khronos/egl/EGL10;->EGL_NO_SURFACE:Ljavax/microedition/khronos/egl/EGLSurface;

    if-ne v6, v7, :cond_7

    .line 724
    const/16 v1, 0x300d

    goto :goto_0

    .line 703
    :cond_6
    iget v6, p0, Lcom/adobe/air/FlashEGL10;->kSwapPreserveOff:I

    if-ne p2, v6, :cond_4

    .line 705
    const-string v6, "Before eglCreateWindowSurface"

    invoke-direct {p0, v6}, Lcom/adobe/air/FlashEGL10;->checkEglError(Ljava/lang/String;)I

    .line 706
    iget-object v6, p0, Lcom/adobe/air/FlashEGL10;->mEgl:Ljavax/microedition/khronos/egl/EGL10;

    iget-object v7, p0, Lcom/adobe/air/FlashEGL10;->mEglDisplay:Ljavax/microedition/khronos/egl/EGLDisplay;

    iget-object v8, p0, Lcom/adobe/air/FlashEGL10;->mEglConfig:Ljavax/microedition/khronos/egl/EGLConfig;

    invoke-virtual {p1}, Landroid/view/SurfaceView;->getHolder()Landroid/view/SurfaceHolder;

    move-result-object v9

    sget-object v10, Lcom/adobe/air/FlashEGL10;->fbWindowSurfaceOffAttrs:[I

    invoke-interface {v6, v7, v8, v9, v10}, Ljavax/microedition/khronos/egl/EGL10;->eglCreateWindowSurface(Ljavax/microedition/khronos/egl/EGLDisplay;Ljavax/microedition/khronos/egl/EGLConfig;Ljava/lang/Object;[I)Ljavax/microedition/khronos/egl/EGLSurface;

    move-result-object v6

    iput-object v6, p0, Lcom/adobe/air/FlashEGL10;->mEglWindowSurface:Ljavax/microedition/khronos/egl/EGLSurface;

    .line 707
    iget-object v6, p0, Lcom/adobe/air/FlashEGL10;->mEglWindowSurface:Ljavax/microedition/khronos/egl/EGLSurface;

    sget-object v7, Ljavax/microedition/khronos/egl/EGL10;->EGL_NO_SURFACE:Ljavax/microedition/khronos/egl/EGLSurface;

    if-ne v6, v7, :cond_4

    .line 708
    const-string v6, "After eglCreateWindowSurface"

    invoke-direct {p0, v6}, Lcom/adobe/air/FlashEGL10;->checkEglError(Ljava/lang/String;)I

    .line 709
    const/4 v0, 0x0

    goto :goto_1

    .line 730
    :cond_7
    iget-object v6, p0, Lcom/adobe/air/FlashEGL10;->mEglWindowSurface:Ljavax/microedition/khronos/egl/EGLSurface;

    iput-object v6, p0, Lcom/adobe/air/FlashEGL10;->mEglSurface:Ljavax/microedition/khronos/egl/EGLSurface;

    .line 732
    if-eqz v2, :cond_8

    move-object v6, p1

    .line 734
    check-cast v6, Lcom/adobe/air/AIRWindowSurfaceView;

    invoke-virtual {v6, p0}, Lcom/adobe/air/AIRWindowSurfaceView;->setFlashEGL(Lcom/adobe/air/FlashEGL;)V

    .line 738
    check-cast p1, Lcom/adobe/air/AIRWindowSurfaceView;

    .end local p1    # "view":Landroid/view/SurfaceView;
    invoke-virtual {p1}, Lcom/adobe/air/AIRWindowSurfaceView;->getActivityWrapper()Lcom/adobe/air/AndroidActivityWrapper;

    move-result-object v6

    invoke-virtual {v6}, Lcom/adobe/air/AndroidActivityWrapper;->getActivity()Landroid/app/Activity;

    move-result-object v3

    .line 739
    .local v3, "main_activity":Landroid/app/Activity;
    if-eqz v3, :cond_8

    .line 742
    invoke-virtual {v3}, Landroid/app/Activity;->getWindow()Landroid/view/Window;

    move-result-object v4

    .line 743
    .local v4, "main_window":Landroid/view/Window;
    const/16 v6, 0x22

    invoke-virtual {v4, v6}, Landroid/view/Window;->setSoftInputMode(I)V

    .line 747
    .end local v3    # "main_activity":Landroid/app/Activity;
    .end local v4    # "main_window":Landroid/view/Window;
    :cond_8
    const/4 v6, 0x1

    new-array v5, v6, [I

    .line 748
    .local v5, "swapBehavior":[I
    const/4 v6, 0x0

    const/4 v7, 0x0

    aput v7, v5, v6

    .line 749
    const/4 v6, 0x0

    iput-boolean v6, p0, Lcom/adobe/air/FlashEGL10;->mIsBufferPreserve:Z

    .line 750
    if-eqz v0, :cond_9

    iget-object v6, p0, Lcom/adobe/air/FlashEGL10;->mEgl:Ljavax/microedition/khronos/egl/EGL10;

    iget-object v7, p0, Lcom/adobe/air/FlashEGL10;->mEglDisplay:Ljavax/microedition/khronos/egl/EGLDisplay;

    iget-object v8, p0, Lcom/adobe/air/FlashEGL10;->mEglSurface:Ljavax/microedition/khronos/egl/EGLSurface;

    sget v9, Lcom/adobe/air/FlashEGL10;->EGL_SWAP_BEHAVIOR:I

    invoke-interface {v6, v7, v8, v9, v5}, Ljavax/microedition/khronos/egl/EGL10;->eglQuerySurface(Ljavax/microedition/khronos/egl/EGLDisplay;Ljavax/microedition/khronos/egl/EGLSurface;I[I)Z

    move-result v6

    if-eqz v6, :cond_9

    .line 751
    const/4 v6, 0x0

    aget v6, v5, v6

    sget v7, Lcom/adobe/air/FlashEGL10;->EGL_BUFFER_PRESERVED:I

    if-ne v6, v7, :cond_a

    const/4 v6, 0x1

    :goto_2
    iput-boolean v6, p0, Lcom/adobe/air/FlashEGL10;->mIsBufferPreserve:Z

    .line 757
    :cond_9
    invoke-virtual {p0}, Lcom/adobe/air/FlashEGL10;->MakeGLCurrent()I

    move-result v1

    goto/16 :goto_0

    .line 751
    :cond_a
    const/4 v6, 0x0

    goto :goto_2
.end method

.method public DestroyGLContext()Z
    .locals 6

    .prologue
    .line 499
    iget-object v1, p0, Lcom/adobe/air/FlashEGL10;->mEglContext:Ljavax/microedition/khronos/egl/EGLContext;

    sget-object v2, Ljavax/microedition/khronos/egl/EGL10;->EGL_NO_CONTEXT:Ljavax/microedition/khronos/egl/EGLContext;

    if-eq v1, v2, :cond_0

    iget-object v1, p0, Lcom/adobe/air/FlashEGL10;->mEglDisplay:Ljavax/microedition/khronos/egl/EGLDisplay;

    sget-object v2, Ljavax/microedition/khronos/egl/EGL10;->EGL_NO_DISPLAY:Ljavax/microedition/khronos/egl/EGLDisplay;

    if-ne v1, v2, :cond_1

    .line 501
    :cond_0
    const/4 v0, 0x0

    .line 517
    :goto_0
    return v0

    .line 504
    :cond_1
    const-string v1, "DestroyGLContext: Before eglMakeCurrent for noSurface"

    invoke-direct {p0, v1}, Lcom/adobe/air/FlashEGL10;->checkEglError(Ljava/lang/String;)I

    .line 505
    iget-object v1, p0, Lcom/adobe/air/FlashEGL10;->mEgl:Ljavax/microedition/khronos/egl/EGL10;

    iget-object v2, p0, Lcom/adobe/air/FlashEGL10;->mEglDisplay:Ljavax/microedition/khronos/egl/EGLDisplay;

    sget-object v3, Ljavax/microedition/khronos/egl/EGL10;->EGL_NO_SURFACE:Ljavax/microedition/khronos/egl/EGLSurface;

    sget-object v4, Ljavax/microedition/khronos/egl/EGL10;->EGL_NO_SURFACE:Ljavax/microedition/khronos/egl/EGLSurface;

    sget-object v5, Ljavax/microedition/khronos/egl/EGL10;->EGL_NO_CONTEXT:Ljavax/microedition/khronos/egl/EGLContext;

    invoke-interface {v1, v2, v3, v4, v5}, Ljavax/microedition/khronos/egl/EGL10;->eglMakeCurrent(Ljavax/microedition/khronos/egl/EGLDisplay;Ljavax/microedition/khronos/egl/EGLSurface;Ljavax/microedition/khronos/egl/EGLSurface;Ljavax/microedition/khronos/egl/EGLContext;)Z

    .line 506
    const-string v1, "DestroyGLContext: After eglMakeCurrent"

    invoke-direct {p0, v1}, Lcom/adobe/air/FlashEGL10;->checkEglError(Ljava/lang/String;)I

    .line 508
    iget-object v1, p0, Lcom/adobe/air/FlashEGL10;->mEglPbufferSurface:Ljavax/microedition/khronos/egl/EGLSurface;

    sget-object v2, Ljavax/microedition/khronos/egl/EGL10;->EGL_NO_SURFACE:Ljavax/microedition/khronos/egl/EGLSurface;

    if-eq v1, v2, :cond_2

    .line 509
    iget-object v1, p0, Lcom/adobe/air/FlashEGL10;->mEgl:Ljavax/microedition/khronos/egl/EGL10;

    iget-object v2, p0, Lcom/adobe/air/FlashEGL10;->mEglDisplay:Ljavax/microedition/khronos/egl/EGLDisplay;

    iget-object v3, p0, Lcom/adobe/air/FlashEGL10;->mEglPbufferSurface:Ljavax/microedition/khronos/egl/EGLSurface;

    invoke-interface {v1, v2, v3}, Ljavax/microedition/khronos/egl/EGL10;->eglDestroySurface(Ljavax/microedition/khronos/egl/EGLDisplay;Ljavax/microedition/khronos/egl/EGLSurface;)Z

    .line 510
    sget-object v1, Ljavax/microedition/khronos/egl/EGL10;->EGL_NO_SURFACE:Ljavax/microedition/khronos/egl/EGLSurface;

    iput-object v1, p0, Lcom/adobe/air/FlashEGL10;->mEglPbufferSurface:Ljavax/microedition/khronos/egl/EGLSurface;

    .line 513
    :cond_2
    const-string v1, "Before eglDestroyContext"

    invoke-direct {p0, v1}, Lcom/adobe/air/FlashEGL10;->checkEglError(Ljava/lang/String;)I

    .line 514
    iget-object v1, p0, Lcom/adobe/air/FlashEGL10;->mEgl:Ljavax/microedition/khronos/egl/EGL10;

    iget-object v2, p0, Lcom/adobe/air/FlashEGL10;->mEglDisplay:Ljavax/microedition/khronos/egl/EGLDisplay;

    iget-object v3, p0, Lcom/adobe/air/FlashEGL10;->mEglContext:Ljavax/microedition/khronos/egl/EGLContext;

    invoke-interface {v1, v2, v3}, Ljavax/microedition/khronos/egl/EGL10;->eglDestroyContext(Ljavax/microedition/khronos/egl/EGLDisplay;Ljavax/microedition/khronos/egl/EGLContext;)Z

    move-result v0

    .line 515
    .local v0, "result":Z
    const-string v1, "After eglDestroyContext"

    invoke-direct {p0, v1}, Lcom/adobe/air/FlashEGL10;->checkEglError(Ljava/lang/String;)I

    .line 516
    sget-object v1, Ljavax/microedition/khronos/egl/EGL10;->EGL_NO_CONTEXT:Ljavax/microedition/khronos/egl/EGLContext;

    iput-object v1, p0, Lcom/adobe/air/FlashEGL10;->mEglContext:Ljavax/microedition/khronos/egl/EGLContext;

    goto :goto_0
.end method

.method public DestroyWindowSurface()Z
    .locals 7

    .prologue
    const/16 v6, 0x3000

    const/4 v0, 0x0

    .line 762
    iget-object v1, p0, Lcom/adobe/air/FlashEGL10;->mEglWindowSurface:Ljavax/microedition/khronos/egl/EGLSurface;

    sget-object v2, Ljavax/microedition/khronos/egl/EGL10;->EGL_NO_SURFACE:Ljavax/microedition/khronos/egl/EGLSurface;

    if-eq v1, v2, :cond_0

    .line 765
    const-string v1, "Before eglMakeCurrent"

    invoke-direct {p0, v1}, Lcom/adobe/air/FlashEGL10;->checkEglError(Ljava/lang/String;)I

    .line 766
    iget-object v1, p0, Lcom/adobe/air/FlashEGL10;->mEgl:Ljavax/microedition/khronos/egl/EGL10;

    iget-object v2, p0, Lcom/adobe/air/FlashEGL10;->mEglDisplay:Ljavax/microedition/khronos/egl/EGLDisplay;

    sget-object v3, Ljavax/microedition/khronos/egl/EGL10;->EGL_NO_SURFACE:Ljavax/microedition/khronos/egl/EGLSurface;

    sget-object v4, Ljavax/microedition/khronos/egl/EGL10;->EGL_NO_SURFACE:Ljavax/microedition/khronos/egl/EGLSurface;

    sget-object v5, Ljavax/microedition/khronos/egl/EGL10;->EGL_NO_CONTEXT:Ljavax/microedition/khronos/egl/EGLContext;

    invoke-interface {v1, v2, v3, v4, v5}, Ljavax/microedition/khronos/egl/EGL10;->eglMakeCurrent(Ljavax/microedition/khronos/egl/EGLDisplay;Ljavax/microedition/khronos/egl/EGLSurface;Ljavax/microedition/khronos/egl/EGLSurface;Ljavax/microedition/khronos/egl/EGLContext;)Z

    .line 768
    const-string v1, "After eglMakeCurrent"

    invoke-direct {p0, v1}, Lcom/adobe/air/FlashEGL10;->checkEglError(Ljava/lang/String;)I

    move-result v1

    if-eq v6, v1, :cond_1

    .line 790
    :cond_0
    :goto_0
    return v0

    .line 771
    :cond_1
    const-string v1, "Before eglDestroySurface (window)"

    invoke-direct {p0, v1}, Lcom/adobe/air/FlashEGL10;->checkEglError(Ljava/lang/String;)I

    .line 772
    iget-object v1, p0, Lcom/adobe/air/FlashEGL10;->mEgl:Ljavax/microedition/khronos/egl/EGL10;

    iget-object v2, p0, Lcom/adobe/air/FlashEGL10;->mEglDisplay:Ljavax/microedition/khronos/egl/EGLDisplay;

    iget-object v3, p0, Lcom/adobe/air/FlashEGL10;->mEglWindowSurface:Ljavax/microedition/khronos/egl/EGLSurface;

    invoke-interface {v1, v2, v3}, Ljavax/microedition/khronos/egl/EGL10;->eglDestroySurface(Ljavax/microedition/khronos/egl/EGLDisplay;Ljavax/microedition/khronos/egl/EGLSurface;)Z

    .line 773
    const-string v1, "After eglDestroySurface (window)"

    invoke-direct {p0, v1}, Lcom/adobe/air/FlashEGL10;->checkEglError(Ljava/lang/String;)I

    move-result v1

    if-ne v6, v1, :cond_0

    .line 776
    iget-object v1, p0, Lcom/adobe/air/FlashEGL10;->mEglSurface:Ljavax/microedition/khronos/egl/EGLSurface;

    iget-object v2, p0, Lcom/adobe/air/FlashEGL10;->mEglWindowSurface:Ljavax/microedition/khronos/egl/EGLSurface;

    if-ne v1, v2, :cond_2

    .line 777
    sget-object v1, Ljavax/microedition/khronos/egl/EGL10;->EGL_NO_SURFACE:Ljavax/microedition/khronos/egl/EGLSurface;

    iput-object v1, p0, Lcom/adobe/air/FlashEGL10;->mEglSurface:Ljavax/microedition/khronos/egl/EGLSurface;

    .line 778
    :cond_2
    sget-object v1, Ljavax/microedition/khronos/egl/EGL10;->EGL_NO_SURFACE:Ljavax/microedition/khronos/egl/EGLSurface;

    iput-object v1, p0, Lcom/adobe/air/FlashEGL10;->mEglWindowSurface:Ljavax/microedition/khronos/egl/EGLSurface;

    .line 780
    iget-object v1, p0, Lcom/adobe/air/FlashEGL10;->mEglPbufferSurface:Ljavax/microedition/khronos/egl/EGLSurface;

    sget-object v2, Ljavax/microedition/khronos/egl/EGL10;->EGL_NO_SURFACE:Ljavax/microedition/khronos/egl/EGLSurface;

    if-eq v1, v2, :cond_3

    iget-object v1, p0, Lcom/adobe/air/FlashEGL10;->mEglContext:Ljavax/microedition/khronos/egl/EGLContext;

    sget-object v2, Ljavax/microedition/khronos/egl/EGL10;->EGL_NO_CONTEXT:Ljavax/microedition/khronos/egl/EGLContext;

    if-eq v1, v2, :cond_3

    .line 782
    iget-object v1, p0, Lcom/adobe/air/FlashEGL10;->mEglPbufferSurface:Ljavax/microedition/khronos/egl/EGLSurface;

    iput-object v1, p0, Lcom/adobe/air/FlashEGL10;->mEglSurface:Ljavax/microedition/khronos/egl/EGLSurface;

    .line 783
    iget-object v1, p0, Lcom/adobe/air/FlashEGL10;->mEgl:Ljavax/microedition/khronos/egl/EGL10;

    iget-object v2, p0, Lcom/adobe/air/FlashEGL10;->mEglDisplay:Ljavax/microedition/khronos/egl/EGLDisplay;

    iget-object v3, p0, Lcom/adobe/air/FlashEGL10;->mEglSurface:Ljavax/microedition/khronos/egl/EGLSurface;

    iget-object v4, p0, Lcom/adobe/air/FlashEGL10;->mEglSurface:Ljavax/microedition/khronos/egl/EGLSurface;

    iget-object v5, p0, Lcom/adobe/air/FlashEGL10;->mEglContext:Ljavax/microedition/khronos/egl/EGLContext;

    invoke-interface {v1, v2, v3, v4, v5}, Ljavax/microedition/khronos/egl/EGL10;->eglMakeCurrent(Ljavax/microedition/khronos/egl/EGLDisplay;Ljavax/microedition/khronos/egl/EGLSurface;Ljavax/microedition/khronos/egl/EGLSurface;Ljavax/microedition/khronos/egl/EGLContext;)Z

    .line 784
    const-string v1, "After eglMakeCurrent"

    invoke-direct {p0, v1}, Lcom/adobe/air/FlashEGL10;->checkEglError(Ljava/lang/String;)I

    move-result v1

    if-ne v6, v1, :cond_0

    .line 788
    :cond_3
    const/4 v0, 0x1

    goto :goto_0
.end method

.method public FlashEGL10()V
    .locals 2

    .prologue
    const/4 v1, 0x0

    .line 84
    iput-object v1, p0, Lcom/adobe/air/FlashEGL10;->mEgl:Ljavax/microedition/khronos/egl/EGL10;

    .line 85
    sget-object v0, Ljavax/microedition/khronos/egl/EGL10;->EGL_NO_DISPLAY:Ljavax/microedition/khronos/egl/EGLDisplay;

    iput-object v0, p0, Lcom/adobe/air/FlashEGL10;->mEglDisplay:Ljavax/microedition/khronos/egl/EGLDisplay;

    .line 86
    iput-object v1, p0, Lcom/adobe/air/FlashEGL10;->mEglConfig:Ljavax/microedition/khronos/egl/EGLConfig;

    .line 87
    sget-object v0, Ljavax/microedition/khronos/egl/EGL10;->EGL_NO_CONTEXT:Ljavax/microedition/khronos/egl/EGLContext;

    iput-object v0, p0, Lcom/adobe/air/FlashEGL10;->mEglContext:Ljavax/microedition/khronos/egl/EGLContext;

    .line 88
    sget-object v0, Ljavax/microedition/khronos/egl/EGL10;->EGL_NO_SURFACE:Ljavax/microedition/khronos/egl/EGLSurface;

    iput-object v0, p0, Lcom/adobe/air/FlashEGL10;->mEglSurface:Ljavax/microedition/khronos/egl/EGLSurface;

    .line 89
    sget-object v0, Ljavax/microedition/khronos/egl/EGL10;->EGL_NO_SURFACE:Ljavax/microedition/khronos/egl/EGLSurface;

    iput-object v0, p0, Lcom/adobe/air/FlashEGL10;->mEglWindowSurface:Ljavax/microedition/khronos/egl/EGLSurface;

    .line 90
    sget-object v0, Ljavax/microedition/khronos/egl/EGL10;->EGL_NO_SURFACE:Ljavax/microedition/khronos/egl/EGLSurface;

    iput-object v0, p0, Lcom/adobe/air/FlashEGL10;->mEglPbufferSurface:Ljavax/microedition/khronos/egl/EGLSurface;

    .line 91
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/adobe/air/FlashEGL10;->mIsARGBSurface:Z

    .line 92
    return-void
.end method

.method public GetConfigs(ZZ)[I
    .locals 12
    .param p1, "hasEglNvCoverageSample"    # Z
    .param p2, "isEglVersion_1_4"    # Z

    .prologue
    const/4 v10, 0x1

    const/4 v11, 0x0

    .line 220
    iget v0, p0, Lcom/adobe/air/FlashEGL10;->mEglConfigCount:I

    iget v1, p0, Lcom/adobe/air/FlashEGL10;->kNumElements:I

    mul-int/2addr v0, v1

    new-array v6, v0, [I

    .line 221
    .local v6, "arr":[I
    new-array v5, v10, [I

    .line 222
    .local v5, "num_config":[I
    new-array v9, v10, [I

    .line 225
    .local v9, "retVal":[I
    iget v0, p0, Lcom/adobe/air/FlashEGL10;->mEglConfigCount:I

    new-array v0, v0, [Ljavax/microedition/khronos/egl/EGLConfig;

    iput-object v0, p0, Lcom/adobe/air/FlashEGL10;->mEglConfigList:[Ljavax/microedition/khronos/egl/EGLConfig;

    .line 227
    const-string v0, "Before eglChooseConfig"

    invoke-direct {p0, v0}, Lcom/adobe/air/FlashEGL10;->checkEglError(Ljava/lang/String;)I

    .line 228
    sget-object v0, Lcom/adobe/air/FlashEGL10;->cfgAttrs:[I

    const/4 v1, 0x5

    aput v1, v0, v10

    .line 229
    iget-object v1, p0, Lcom/adobe/air/FlashEGL10;->mEglDisplay:Ljavax/microedition/khronos/egl/EGLDisplay;

    sget-object v2, Lcom/adobe/air/FlashEGL10;->cfgAttrs:[I

    iget-object v3, p0, Lcom/adobe/air/FlashEGL10;->mEglConfigList:[Ljavax/microedition/khronos/egl/EGLConfig;

    iget v4, p0, Lcom/adobe/air/FlashEGL10;->mEglConfigCount:I

    move-object v0, p0

    invoke-virtual/range {v0 .. v5}, Lcom/adobe/air/FlashEGL10;->ChooseConfig(Ljavax/microedition/khronos/egl/EGLDisplay;[I[Ljavax/microedition/khronos/egl/EGLConfig;I[I)Z

    .line 230
    const-string v0, "After eglChooseConfig"

    invoke-direct {p0, v0}, Lcom/adobe/air/FlashEGL10;->checkEglError(Ljava/lang/String;)I

    .line 231
    sget-object v0, Lcom/adobe/air/FlashEGL10;->cfgAttrs:[I

    const/4 v1, -0x1

    aput v1, v0, v10

    .line 233
    aget v8, v5, v11

    iput v8, p0, Lcom/adobe/air/FlashEGL10;->mEglConfigCount:I

    .line 234
    .local v8, "max":I
    const/4 v7, 0x0

    .local v7, "i":I
    :goto_0
    if-ge v7, v8, :cond_5

    .line 236
    iget-object v0, p0, Lcom/adobe/air/FlashEGL10;->mEgl:Ljavax/microedition/khronos/egl/EGL10;

    iget-object v1, p0, Lcom/adobe/air/FlashEGL10;->mEglDisplay:Ljavax/microedition/khronos/egl/EGLDisplay;

    iget-object v2, p0, Lcom/adobe/air/FlashEGL10;->mEglConfigList:[Ljavax/microedition/khronos/egl/EGLConfig;

    aget-object v2, v2, v7

    const/16 v3, 0x3033

    invoke-interface {v0, v1, v2, v3, v9}, Ljavax/microedition/khronos/egl/EGL10;->eglGetConfigAttrib(Ljavax/microedition/khronos/egl/EGLDisplay;Ljavax/microedition/khronos/egl/EGLConfig;I[I)Z

    .line 237
    iget v0, p0, Lcom/adobe/air/FlashEGL10;->kSurfaceTypes:I

    invoke-direct {p0, v7, v0}, Lcom/adobe/air/FlashEGL10;->XX(II)I

    move-result v0

    aget v1, v9, v11

    aput v1, v6, v0

    .line 239
    iget v0, p0, Lcom/adobe/air/FlashEGL10;->kConfigId:I

    invoke-direct {p0, v7, v0}, Lcom/adobe/air/FlashEGL10;->XX(II)I

    move-result v0

    aput v7, v6, v0

    .line 241
    iget-object v0, p0, Lcom/adobe/air/FlashEGL10;->mEgl:Ljavax/microedition/khronos/egl/EGL10;

    iget-object v1, p0, Lcom/adobe/air/FlashEGL10;->mEglDisplay:Ljavax/microedition/khronos/egl/EGLDisplay;

    iget-object v2, p0, Lcom/adobe/air/FlashEGL10;->mEglConfigList:[Ljavax/microedition/khronos/egl/EGLConfig;

    aget-object v2, v2, v7

    const/16 v3, 0x3024

    invoke-interface {v0, v1, v2, v3, v9}, Ljavax/microedition/khronos/egl/EGL10;->eglGetConfigAttrib(Ljavax/microedition/khronos/egl/EGLDisplay;Ljavax/microedition/khronos/egl/EGLConfig;I[I)Z

    .line 242
    iget v0, p0, Lcom/adobe/air/FlashEGL10;->kRedBits:I

    invoke-direct {p0, v7, v0}, Lcom/adobe/air/FlashEGL10;->XX(II)I

    move-result v0

    aget v1, v9, v11

    aput v1, v6, v0

    .line 244
    iget-object v0, p0, Lcom/adobe/air/FlashEGL10;->mEgl:Ljavax/microedition/khronos/egl/EGL10;

    iget-object v1, p0, Lcom/adobe/air/FlashEGL10;->mEglDisplay:Ljavax/microedition/khronos/egl/EGLDisplay;

    iget-object v2, p0, Lcom/adobe/air/FlashEGL10;->mEglConfigList:[Ljavax/microedition/khronos/egl/EGLConfig;

    aget-object v2, v2, v7

    const/16 v3, 0x3023

    invoke-interface {v0, v1, v2, v3, v9}, Ljavax/microedition/khronos/egl/EGL10;->eglGetConfigAttrib(Ljavax/microedition/khronos/egl/EGLDisplay;Ljavax/microedition/khronos/egl/EGLConfig;I[I)Z

    .line 245
    iget v0, p0, Lcom/adobe/air/FlashEGL10;->kGreenBits:I

    invoke-direct {p0, v7, v0}, Lcom/adobe/air/FlashEGL10;->XX(II)I

    move-result v0

    aget v1, v9, v11

    aput v1, v6, v0

    .line 247
    iget-object v0, p0, Lcom/adobe/air/FlashEGL10;->mEgl:Ljavax/microedition/khronos/egl/EGL10;

    iget-object v1, p0, Lcom/adobe/air/FlashEGL10;->mEglDisplay:Ljavax/microedition/khronos/egl/EGLDisplay;

    iget-object v2, p0, Lcom/adobe/air/FlashEGL10;->mEglConfigList:[Ljavax/microedition/khronos/egl/EGLConfig;

    aget-object v2, v2, v7

    const/16 v3, 0x3022

    invoke-interface {v0, v1, v2, v3, v9}, Ljavax/microedition/khronos/egl/EGL10;->eglGetConfigAttrib(Ljavax/microedition/khronos/egl/EGLDisplay;Ljavax/microedition/khronos/egl/EGLConfig;I[I)Z

    .line 248
    iget v0, p0, Lcom/adobe/air/FlashEGL10;->kBlueBits:I

    invoke-direct {p0, v7, v0}, Lcom/adobe/air/FlashEGL10;->XX(II)I

    move-result v0

    aget v1, v9, v11

    aput v1, v6, v0

    .line 250
    iget-object v0, p0, Lcom/adobe/air/FlashEGL10;->mEgl:Ljavax/microedition/khronos/egl/EGL10;

    iget-object v1, p0, Lcom/adobe/air/FlashEGL10;->mEglDisplay:Ljavax/microedition/khronos/egl/EGLDisplay;

    iget-object v2, p0, Lcom/adobe/air/FlashEGL10;->mEglConfigList:[Ljavax/microedition/khronos/egl/EGLConfig;

    aget-object v2, v2, v7

    const/16 v3, 0x3021

    invoke-interface {v0, v1, v2, v3, v9}, Ljavax/microedition/khronos/egl/EGL10;->eglGetConfigAttrib(Ljavax/microedition/khronos/egl/EGLDisplay;Ljavax/microedition/khronos/egl/EGLConfig;I[I)Z

    .line 251
    iget v0, p0, Lcom/adobe/air/FlashEGL10;->kAlphaBits:I

    invoke-direct {p0, v7, v0}, Lcom/adobe/air/FlashEGL10;->XX(II)I

    move-result v0

    aget v1, v9, v11

    aput v1, v6, v0

    .line 253
    iget-object v0, p0, Lcom/adobe/air/FlashEGL10;->mEgl:Ljavax/microedition/khronos/egl/EGL10;

    iget-object v1, p0, Lcom/adobe/air/FlashEGL10;->mEglDisplay:Ljavax/microedition/khronos/egl/EGLDisplay;

    iget-object v2, p0, Lcom/adobe/air/FlashEGL10;->mEglConfigList:[Ljavax/microedition/khronos/egl/EGLConfig;

    aget-object v2, v2, v7

    const/16 v3, 0x3020

    invoke-interface {v0, v1, v2, v3, v9}, Ljavax/microedition/khronos/egl/EGL10;->eglGetConfigAttrib(Ljavax/microedition/khronos/egl/EGLDisplay;Ljavax/microedition/khronos/egl/EGLConfig;I[I)Z

    .line 254
    iget v0, p0, Lcom/adobe/air/FlashEGL10;->kColorBits:I

    invoke-direct {p0, v7, v0}, Lcom/adobe/air/FlashEGL10;->XX(II)I

    move-result v0

    aget v1, v9, v11

    aput v1, v6, v0

    .line 256
    iget-object v0, p0, Lcom/adobe/air/FlashEGL10;->mEgl:Ljavax/microedition/khronos/egl/EGL10;

    iget-object v1, p0, Lcom/adobe/air/FlashEGL10;->mEglDisplay:Ljavax/microedition/khronos/egl/EGLDisplay;

    iget-object v2, p0, Lcom/adobe/air/FlashEGL10;->mEglConfigList:[Ljavax/microedition/khronos/egl/EGLConfig;

    aget-object v2, v2, v7

    const/16 v3, 0x3025

    invoke-interface {v0, v1, v2, v3, v9}, Ljavax/microedition/khronos/egl/EGL10;->eglGetConfigAttrib(Ljavax/microedition/khronos/egl/EGLDisplay;Ljavax/microedition/khronos/egl/EGLConfig;I[I)Z

    .line 257
    iget v0, p0, Lcom/adobe/air/FlashEGL10;->kDepthBits:I

    invoke-direct {p0, v7, v0}, Lcom/adobe/air/FlashEGL10;->XX(II)I

    move-result v0

    aget v1, v9, v11

    aput v1, v6, v0

    .line 259
    iget-object v0, p0, Lcom/adobe/air/FlashEGL10;->mEgl:Ljavax/microedition/khronos/egl/EGL10;

    iget-object v1, p0, Lcom/adobe/air/FlashEGL10;->mEglDisplay:Ljavax/microedition/khronos/egl/EGLDisplay;

    iget-object v2, p0, Lcom/adobe/air/FlashEGL10;->mEglConfigList:[Ljavax/microedition/khronos/egl/EGLConfig;

    aget-object v2, v2, v7

    const/16 v3, 0x3026

    invoke-interface {v0, v1, v2, v3, v9}, Ljavax/microedition/khronos/egl/EGL10;->eglGetConfigAttrib(Ljavax/microedition/khronos/egl/EGLDisplay;Ljavax/microedition/khronos/egl/EGLConfig;I[I)Z

    .line 260
    iget v0, p0, Lcom/adobe/air/FlashEGL10;->kStencilBits:I

    invoke-direct {p0, v7, v0}, Lcom/adobe/air/FlashEGL10;->XX(II)I

    move-result v0

    aget v1, v9, v11

    aput v1, v6, v0

    .line 262
    iget v0, p0, Lcom/adobe/air/FlashEGL10;->kCsaaSamp:I

    invoke-direct {p0, v7, v0}, Lcom/adobe/air/FlashEGL10;->XX(II)I

    move-result v0

    aput v11, v6, v0

    .line 263
    iget v0, p0, Lcom/adobe/air/FlashEGL10;->kMsaaSamp:I

    invoke-direct {p0, v7, v0}, Lcom/adobe/air/FlashEGL10;->XX(II)I

    move-result v0

    aput v11, v6, v0

    .line 265
    if-eqz p1, :cond_2

    .line 266
    iget-object v0, p0, Lcom/adobe/air/FlashEGL10;->mEgl:Ljavax/microedition/khronos/egl/EGL10;

    iget-object v1, p0, Lcom/adobe/air/FlashEGL10;->mEglDisplay:Ljavax/microedition/khronos/egl/EGLDisplay;

    iget-object v2, p0, Lcom/adobe/air/FlashEGL10;->mEglConfigList:[Ljavax/microedition/khronos/egl/EGLConfig;

    aget-object v2, v2, v7

    sget v3, Lcom/adobe/air/FlashEGL10;->EGL_COVERAGE_SAMPLES_NV:I

    invoke-interface {v0, v1, v2, v3, v9}, Ljavax/microedition/khronos/egl/EGL10;->eglGetConfigAttrib(Ljavax/microedition/khronos/egl/EGLDisplay;Ljavax/microedition/khronos/egl/EGLConfig;I[I)Z

    .line 267
    aget v0, v9, v11

    if-eq v0, v10, :cond_0

    .line 268
    iget v0, p0, Lcom/adobe/air/FlashEGL10;->kCsaaSamp:I

    invoke-direct {p0, v7, v0}, Lcom/adobe/air/FlashEGL10;->XX(II)I

    move-result v0

    aget v1, v9, v11

    aput v1, v6, v0

    .line 276
    :cond_0
    :goto_1
    if-eqz p2, :cond_4

    .line 278
    iget v0, p0, Lcom/adobe/air/FlashEGL10;->kSwapPreserve:I

    invoke-direct {p0, v7, v0}, Lcom/adobe/air/FlashEGL10;->XX(II)I

    move-result v1

    iget-object v0, p0, Lcom/adobe/air/FlashEGL10;->mEglVersion:[I

    aget v0, v0, v11

    if-gt v0, v10, :cond_1

    iget-object v0, p0, Lcom/adobe/air/FlashEGL10;->mEglVersion:[I

    aget v0, v0, v10

    const/4 v2, 0x3

    if-le v0, v2, :cond_3

    :cond_1
    iget v0, p0, Lcom/adobe/air/FlashEGL10;->kSurfaceTypes:I

    invoke-direct {p0, v7, v0}, Lcom/adobe/air/FlashEGL10;->XX(II)I

    move-result v0

    aget v0, v6, v0

    sget v2, Lcom/adobe/air/FlashEGL10;->EGL_BUFFER_PRESERVED:I

    and-int/2addr v0, v2

    if-eqz v0, :cond_3

    move v0, v10

    :goto_2
    aput v0, v6, v1

    .line 234
    :goto_3
    add-int/lit8 v7, v7, 0x1

    goto/16 :goto_0

    .line 271
    :cond_2
    iget-object v0, p0, Lcom/adobe/air/FlashEGL10;->mEgl:Ljavax/microedition/khronos/egl/EGL10;

    iget-object v1, p0, Lcom/adobe/air/FlashEGL10;->mEglDisplay:Ljavax/microedition/khronos/egl/EGLDisplay;

    iget-object v2, p0, Lcom/adobe/air/FlashEGL10;->mEglConfigList:[Ljavax/microedition/khronos/egl/EGLConfig;

    aget-object v2, v2, v7

    const/16 v3, 0x3031

    invoke-interface {v0, v1, v2, v3, v9}, Ljavax/microedition/khronos/egl/EGL10;->eglGetConfigAttrib(Ljavax/microedition/khronos/egl/EGLDisplay;Ljavax/microedition/khronos/egl/EGLConfig;I[I)Z

    .line 272
    aget v0, v9, v11

    if-eq v0, v10, :cond_0

    .line 273
    iget v0, p0, Lcom/adobe/air/FlashEGL10;->kMsaaSamp:I

    invoke-direct {p0, v7, v0}, Lcom/adobe/air/FlashEGL10;->XX(II)I

    move-result v0

    aget v1, v9, v11

    aput v1, v6, v0

    goto :goto_1

    :cond_3
    move v0, v11

    .line 278
    goto :goto_2

    .line 281
    :cond_4
    iget v0, p0, Lcom/adobe/air/FlashEGL10;->kSwapPreserve:I

    invoke-direct {p0, v7, v0}, Lcom/adobe/air/FlashEGL10;->XX(II)I

    move-result v0

    aput v11, v6, v0

    goto :goto_3

    .line 284
    :cond_5
    return-object v6
.end method

.method public GetNumConfigs()[I
    .locals 10

    .prologue
    const/4 v9, 0x4

    const/4 v8, 0x2

    const/4 v3, 0x0

    const/4 v7, 0x1

    const/4 v4, 0x0

    .line 186
    new-array v6, v9, [I

    .line 187
    .local v6, "arr":[I
    new-array v5, v7, [I

    .line 190
    .local v5, "num_config":[I
    iget-object v1, p0, Lcom/adobe/air/FlashEGL10;->mEglDisplay:Ljavax/microedition/khronos/egl/EGLDisplay;

    sget-object v2, Lcom/adobe/air/FlashEGL10;->cfgAttrs:[I

    move-object v0, p0

    invoke-virtual/range {v0 .. v5}, Lcom/adobe/air/FlashEGL10;->ChooseConfig(Ljavax/microedition/khronos/egl/EGLDisplay;[I[Ljavax/microedition/khronos/egl/EGLConfig;I[I)Z

    .line 191
    aget v0, v5, v4

    aput v0, v6, v4

    iput v0, p0, Lcom/adobe/air/FlashEGL10;->mEglConfigCount:I

    .line 195
    sget-object v0, Lcom/adobe/air/FlashEGL10;->cfgAttrs:[I

    aput v9, v0, v7

    .line 196
    iget-object v1, p0, Lcom/adobe/air/FlashEGL10;->mEglDisplay:Ljavax/microedition/khronos/egl/EGLDisplay;

    sget-object v2, Lcom/adobe/air/FlashEGL10;->cfgAttrs:[I

    move-object v0, p0

    invoke-virtual/range {v0 .. v5}, Lcom/adobe/air/FlashEGL10;->ChooseConfig(Ljavax/microedition/khronos/egl/EGLDisplay;[I[Ljavax/microedition/khronos/egl/EGLConfig;I[I)Z

    .line 197
    aget v0, v5, v4

    aput v0, v6, v7

    iput v0, p0, Lcom/adobe/air/FlashEGL10;->mWindowConfigCount:I

    .line 201
    sget-object v0, Lcom/adobe/air/FlashEGL10;->cfgAttrs:[I

    aput v8, v0, v7

    .line 202
    iget-object v1, p0, Lcom/adobe/air/FlashEGL10;->mEglDisplay:Ljavax/microedition/khronos/egl/EGLDisplay;

    sget-object v2, Lcom/adobe/air/FlashEGL10;->cfgAttrs:[I

    move-object v0, p0

    invoke-virtual/range {v0 .. v5}, Lcom/adobe/air/FlashEGL10;->ChooseConfig(Ljavax/microedition/khronos/egl/EGLDisplay;[I[Ljavax/microedition/khronos/egl/EGLConfig;I[I)Z

    .line 203
    aget v0, v5, v4

    aput v0, v6, v8

    iput v0, p0, Lcom/adobe/air/FlashEGL10;->mPixmapConfigCount:I

    .line 207
    sget-object v0, Lcom/adobe/air/FlashEGL10;->cfgAttrs:[I

    aput v7, v0, v7

    .line 208
    iget-object v1, p0, Lcom/adobe/air/FlashEGL10;->mEglDisplay:Ljavax/microedition/khronos/egl/EGLDisplay;

    sget-object v2, Lcom/adobe/air/FlashEGL10;->cfgAttrs:[I

    move-object v0, p0

    invoke-virtual/range {v0 .. v5}, Lcom/adobe/air/FlashEGL10;->ChooseConfig(Ljavax/microedition/khronos/egl/EGLDisplay;[I[Ljavax/microedition/khronos/egl/EGLConfig;I[I)Z

    .line 209
    const/4 v0, 0x3

    aget v1, v5, v4

    aput v1, v6, v0

    iput v1, p0, Lcom/adobe/air/FlashEGL10;->mPbufferConfigCount:I

    .line 213
    sget-object v0, Lcom/adobe/air/FlashEGL10;->cfgAttrs:[I

    const/4 v1, -0x1

    aput v1, v0, v7

    .line 215
    return-object v6
.end method

.method public GetSurfaceHeight()I
    .locals 5

    .prologue
    .line 117
    const/4 v1, 0x1

    new-array v0, v1, [I

    .line 118
    .local v0, "h":[I
    iget-object v1, p0, Lcom/adobe/air/FlashEGL10;->mEgl:Ljavax/microedition/khronos/egl/EGL10;

    iget-object v2, p0, Lcom/adobe/air/FlashEGL10;->mEglDisplay:Ljavax/microedition/khronos/egl/EGLDisplay;

    iget-object v3, p0, Lcom/adobe/air/FlashEGL10;->mEglSurface:Ljavax/microedition/khronos/egl/EGLSurface;

    const/16 v4, 0x3056

    invoke-interface {v1, v2, v3, v4, v0}, Ljavax/microedition/khronos/egl/EGL10;->eglQuerySurface(Ljavax/microedition/khronos/egl/EGLDisplay;Ljavax/microedition/khronos/egl/EGLSurface;I[I)Z

    .line 120
    const/4 v1, 0x0

    aget v1, v0, v1

    return v1
.end method

.method public GetSurfaceWidth()I
    .locals 5

    .prologue
    .line 109
    const/4 v1, 0x1

    new-array v0, v1, [I

    .line 110
    .local v0, "w":[I
    iget-object v1, p0, Lcom/adobe/air/FlashEGL10;->mEgl:Ljavax/microedition/khronos/egl/EGL10;

    iget-object v2, p0, Lcom/adobe/air/FlashEGL10;->mEglDisplay:Ljavax/microedition/khronos/egl/EGLDisplay;

    iget-object v3, p0, Lcom/adobe/air/FlashEGL10;->mEglSurface:Ljavax/microedition/khronos/egl/EGLSurface;

    const/16 v4, 0x3057

    invoke-interface {v1, v2, v3, v4, v0}, Ljavax/microedition/khronos/egl/EGL10;->eglQuerySurface(Ljavax/microedition/khronos/egl/EGLDisplay;Ljavax/microedition/khronos/egl/EGLSurface;I[I)Z

    .line 112
    const/4 v1, 0x0

    aget v1, v0, v1

    return v1
.end method

.method public HasGLContext()Z
    .locals 2

    .prologue
    .line 104
    iget-object v0, p0, Lcom/adobe/air/FlashEGL10;->mEglContext:Ljavax/microedition/khronos/egl/EGLContext;

    sget-object v1, Ljavax/microedition/khronos/egl/EGL10;->EGL_NO_CONTEXT:Ljavax/microedition/khronos/egl/EGLContext;

    if-eq v0, v1, :cond_0

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public InitEGL()I
    .locals 5

    .prologue
    const/16 v2, 0x3000

    .line 466
    iget-object v1, p0, Lcom/adobe/air/FlashEGL10;->mEglContext:Ljavax/microedition/khronos/egl/EGLContext;

    sget-object v3, Ljavax/microedition/khronos/egl/EGL10;->EGL_NO_CONTEXT:Ljavax/microedition/khronos/egl/EGLContext;

    if-eq v1, v3, :cond_1

    move v0, v2

    .line 494
    :cond_0
    :goto_0
    return v0

    .line 469
    :cond_1
    const/4 v0, 0x0

    .line 473
    .local v0, "eglError":I
    invoke-static {}, Ljavax/microedition/khronos/egl/EGLContext;->getEGL()Ljavax/microedition/khronos/egl/EGL;

    move-result-object v1

    check-cast v1, Ljavax/microedition/khronos/egl/EGL10;

    iput-object v1, p0, Lcom/adobe/air/FlashEGL10;->mEgl:Ljavax/microedition/khronos/egl/EGL10;

    .line 477
    const-string v1, "Before eglGetDisplay"

    invoke-direct {p0, v1}, Lcom/adobe/air/FlashEGL10;->checkEglError(Ljava/lang/String;)I

    .line 478
    iget-object v1, p0, Lcom/adobe/air/FlashEGL10;->mEgl:Ljavax/microedition/khronos/egl/EGL10;

    sget-object v3, Ljavax/microedition/khronos/egl/EGL10;->EGL_DEFAULT_DISPLAY:Ljava/lang/Object;

    invoke-interface {v1, v3}, Ljavax/microedition/khronos/egl/EGL10;->eglGetDisplay(Ljava/lang/Object;)Ljavax/microedition/khronos/egl/EGLDisplay;

    move-result-object v1

    iput-object v1, p0, Lcom/adobe/air/FlashEGL10;->mEglDisplay:Ljavax/microedition/khronos/egl/EGLDisplay;

    .line 479
    const-string v1, "After eglGetDisplay"

    invoke-direct {p0, v1}, Lcom/adobe/air/FlashEGL10;->checkEglError(Ljava/lang/String;)I

    move-result v0

    .line 480
    if-ne v2, v0, :cond_0

    .line 485
    const/4 v1, 0x2

    new-array v1, v1, [I

    iput-object v1, p0, Lcom/adobe/air/FlashEGL10;->mEglVersion:[I

    .line 486
    const-string v1, "Before eglInitialize"

    invoke-direct {p0, v1}, Lcom/adobe/air/FlashEGL10;->checkEglError(Ljava/lang/String;)I

    .line 487
    iget-object v1, p0, Lcom/adobe/air/FlashEGL10;->mEgl:Ljavax/microedition/khronos/egl/EGL10;

    iget-object v3, p0, Lcom/adobe/air/FlashEGL10;->mEglDisplay:Ljavax/microedition/khronos/egl/EGLDisplay;

    iget-object v4, p0, Lcom/adobe/air/FlashEGL10;->mEglVersion:[I

    invoke-interface {v1, v3, v4}, Ljavax/microedition/khronos/egl/EGL10;->eglInitialize(Ljavax/microedition/khronos/egl/EGLDisplay;[I)Z

    .line 488
    const-string v1, "After eglInitialize"

    invoke-direct {p0, v1}, Lcom/adobe/air/FlashEGL10;->checkEglError(Ljava/lang/String;)I

    move-result v0

    .line 489
    if-ne v2, v0, :cond_0

    move v0, v2

    .line 494
    goto :goto_0
.end method

.method public IsARGBSurface()Z
    .locals 1

    .prologue
    .line 795
    iget-boolean v0, p0, Lcom/adobe/air/FlashEGL10;->mIsARGBSurface:Z

    return v0
.end method

.method public IsBufferPreserve()Z
    .locals 1

    .prologue
    .line 800
    iget-boolean v0, p0, Lcom/adobe/air/FlashEGL10;->mIsBufferPreserve:Z

    return v0
.end method

.method public IsEmulator()Z
    .locals 2

    .prologue
    .line 125
    sget-object v0, Landroid/os/Build;->BRAND:Ljava/lang/String;

    const-string v1, "generic"

    invoke-virtual {v0, v1}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    sget-object v0, Landroid/os/Build;->DEVICE:Ljava/lang/String;

    const-string v1, "generic"

    invoke-virtual {v0, v1}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public MakeGLCurrent()I
    .locals 5

    .prologue
    const/16 v0, 0x300d

    .line 642
    iget-object v1, p0, Lcom/adobe/air/FlashEGL10;->mEglContext:Ljavax/microedition/khronos/egl/EGLContext;

    sget-object v2, Ljavax/microedition/khronos/egl/EGL10;->EGL_NO_CONTEXT:Ljavax/microedition/khronos/egl/EGLContext;

    if-ne v1, v2, :cond_1

    .line 645
    const/16 v0, 0x3006

    .line 666
    :cond_0
    :goto_0
    return v0

    .line 648
    :cond_1
    iget-object v1, p0, Lcom/adobe/air/FlashEGL10;->mEglSurface:Ljavax/microedition/khronos/egl/EGLSurface;

    sget-object v2, Ljavax/microedition/khronos/egl/EGL10;->EGL_NO_SURFACE:Ljavax/microedition/khronos/egl/EGLSurface;

    if-eq v1, v2, :cond_0

    .line 654
    iget-object v1, p0, Lcom/adobe/air/FlashEGL10;->mEglDisplay:Ljavax/microedition/khronos/egl/EGLDisplay;

    sget-object v2, Ljavax/microedition/khronos/egl/EGL10;->EGL_NO_DISPLAY:Ljavax/microedition/khronos/egl/EGLDisplay;

    if-ne v1, v2, :cond_2

    .line 657
    const/16 v0, 0x3008

    goto :goto_0

    .line 660
    :cond_2
    sget v1, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v2, 0x17

    if-ne v1, v2, :cond_3

    sget-object v1, Landroid/os/Build;->MODEL:Ljava/lang/String;

    const-string v2, "Nexus 5"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_3

    .line 661
    iget-object v1, p0, Lcom/adobe/air/FlashEGL10;->mEglSurface:Ljavax/microedition/khronos/egl/EGLSurface;

    iget-object v2, p0, Lcom/adobe/air/FlashEGL10;->mEglPbufferSurface:Ljavax/microedition/khronos/egl/EGLSurface;

    if-eq v1, v2, :cond_0

    .line 664
    :cond_3
    const-string v0, "Before eglMakeCurrent"

    invoke-direct {p0, v0}, Lcom/adobe/air/FlashEGL10;->checkEglError(Ljava/lang/String;)I

    .line 665
    iget-object v0, p0, Lcom/adobe/air/FlashEGL10;->mEgl:Ljavax/microedition/khronos/egl/EGL10;

    iget-object v1, p0, Lcom/adobe/air/FlashEGL10;->mEglDisplay:Ljavax/microedition/khronos/egl/EGLDisplay;

    iget-object v2, p0, Lcom/adobe/air/FlashEGL10;->mEglSurface:Ljavax/microedition/khronos/egl/EGLSurface;

    iget-object v3, p0, Lcom/adobe/air/FlashEGL10;->mEglSurface:Ljavax/microedition/khronos/egl/EGLSurface;

    iget-object v4, p0, Lcom/adobe/air/FlashEGL10;->mEglContext:Ljavax/microedition/khronos/egl/EGLContext;

    invoke-interface {v0, v1, v2, v3, v4}, Ljavax/microedition/khronos/egl/EGL10;->eglMakeCurrent(Ljavax/microedition/khronos/egl/EGLDisplay;Ljavax/microedition/khronos/egl/EGLSurface;Ljavax/microedition/khronos/egl/EGLSurface;Ljavax/microedition/khronos/egl/EGLContext;)Z

    .line 666
    const-string v0, "After eglMakeCurrent"

    invoke-direct {p0, v0}, Lcom/adobe/air/FlashEGL10;->checkEglError(Ljava/lang/String;)I

    move-result v0

    goto :goto_0
.end method

.method public ReleaseGPUResources()V
    .locals 5

    .prologue
    .line 587
    iget-object v0, p0, Lcom/adobe/air/FlashEGL10;->mEglContext:Ljavax/microedition/khronos/egl/EGLContext;

    sget-object v1, Ljavax/microedition/khronos/egl/EGL10;->EGL_NO_CONTEXT:Ljavax/microedition/khronos/egl/EGLContext;

    if-ne v0, v1, :cond_0

    .line 625
    :goto_0
    return-void

    .line 593
    :cond_0
    const-string v0, "Before eglMakeCurrent"

    invoke-direct {p0, v0}, Lcom/adobe/air/FlashEGL10;->checkEglError(Ljava/lang/String;)I

    .line 594
    iget-object v0, p0, Lcom/adobe/air/FlashEGL10;->mEgl:Ljavax/microedition/khronos/egl/EGL10;

    iget-object v1, p0, Lcom/adobe/air/FlashEGL10;->mEglDisplay:Ljavax/microedition/khronos/egl/EGLDisplay;

    sget-object v2, Ljavax/microedition/khronos/egl/EGL10;->EGL_NO_SURFACE:Ljavax/microedition/khronos/egl/EGLSurface;

    sget-object v3, Ljavax/microedition/khronos/egl/EGL10;->EGL_NO_SURFACE:Ljavax/microedition/khronos/egl/EGLSurface;

    sget-object v4, Ljavax/microedition/khronos/egl/EGL10;->EGL_NO_CONTEXT:Ljavax/microedition/khronos/egl/EGLContext;

    invoke-interface {v0, v1, v2, v3, v4}, Ljavax/microedition/khronos/egl/EGL10;->eglMakeCurrent(Ljavax/microedition/khronos/egl/EGLDisplay;Ljavax/microedition/khronos/egl/EGLSurface;Ljavax/microedition/khronos/egl/EGLSurface;Ljavax/microedition/khronos/egl/EGLContext;)Z

    .line 595
    const-string v0, "After eglMakeCurrent"

    invoke-direct {p0, v0}, Lcom/adobe/air/FlashEGL10;->checkEglError(Ljava/lang/String;)I

    .line 598
    iget-object v1, p0, Lcom/adobe/air/FlashEGL10;->mEgl:Ljavax/microedition/khronos/egl/EGL10;

    monitor-enter v1

    .line 600
    :try_start_0
    const-string v0, "Before eglDestroySurface"

    invoke-direct {p0, v0}, Lcom/adobe/air/FlashEGL10;->checkEglError(Ljava/lang/String;)I

    .line 601
    iget-object v0, p0, Lcom/adobe/air/FlashEGL10;->mEglWindowSurface:Ljavax/microedition/khronos/egl/EGLSurface;

    sget-object v2, Ljavax/microedition/khronos/egl/EGL10;->EGL_NO_SURFACE:Ljavax/microedition/khronos/egl/EGLSurface;

    if-eq v0, v2, :cond_1

    .line 602
    iget-object v0, p0, Lcom/adobe/air/FlashEGL10;->mEgl:Ljavax/microedition/khronos/egl/EGL10;

    iget-object v2, p0, Lcom/adobe/air/FlashEGL10;->mEglDisplay:Ljavax/microedition/khronos/egl/EGLDisplay;

    iget-object v3, p0, Lcom/adobe/air/FlashEGL10;->mEglWindowSurface:Ljavax/microedition/khronos/egl/EGLSurface;

    invoke-interface {v0, v2, v3}, Ljavax/microedition/khronos/egl/EGL10;->eglDestroySurface(Ljavax/microedition/khronos/egl/EGLDisplay;Ljavax/microedition/khronos/egl/EGLSurface;)Z

    .line 603
    sget-object v0, Ljavax/microedition/khronos/egl/EGL10;->EGL_NO_SURFACE:Ljavax/microedition/khronos/egl/EGLSurface;

    iput-object v0, p0, Lcom/adobe/air/FlashEGL10;->mEglWindowSurface:Ljavax/microedition/khronos/egl/EGLSurface;

    .line 605
    :cond_1
    const-string v0, "After eglDestroySurface (window)"

    invoke-direct {p0, v0}, Lcom/adobe/air/FlashEGL10;->checkEglError(Ljava/lang/String;)I

    .line 606
    monitor-exit v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 608
    iget-object v0, p0, Lcom/adobe/air/FlashEGL10;->mEglPbufferSurface:Ljavax/microedition/khronos/egl/EGLSurface;

    sget-object v1, Ljavax/microedition/khronos/egl/EGL10;->EGL_NO_SURFACE:Ljavax/microedition/khronos/egl/EGLSurface;

    if-eq v0, v1, :cond_2

    .line 610
    const-string v0, "Before eglDestroySurface (pbuffer)"

    invoke-direct {p0, v0}, Lcom/adobe/air/FlashEGL10;->checkEglError(Ljava/lang/String;)I

    .line 611
    iget-object v0, p0, Lcom/adobe/air/FlashEGL10;->mEgl:Ljavax/microedition/khronos/egl/EGL10;

    iget-object v1, p0, Lcom/adobe/air/FlashEGL10;->mEglDisplay:Ljavax/microedition/khronos/egl/EGLDisplay;

    iget-object v2, p0, Lcom/adobe/air/FlashEGL10;->mEglPbufferSurface:Ljavax/microedition/khronos/egl/EGLSurface;

    invoke-interface {v0, v1, v2}, Ljavax/microedition/khronos/egl/EGL10;->eglDestroySurface(Ljavax/microedition/khronos/egl/EGLDisplay;Ljavax/microedition/khronos/egl/EGLSurface;)Z

    .line 612
    const-string v0, "After eglDestroySurface (pbuffer)"

    invoke-direct {p0, v0}, Lcom/adobe/air/FlashEGL10;->checkEglError(Ljava/lang/String;)I

    .line 613
    sget-object v0, Ljavax/microedition/khronos/egl/EGL10;->EGL_NO_SURFACE:Ljavax/microedition/khronos/egl/EGLSurface;

    iput-object v0, p0, Lcom/adobe/air/FlashEGL10;->mEglPbufferSurface:Ljavax/microedition/khronos/egl/EGLSurface;

    .line 617
    :cond_2
    const-string v0, "Before eglDestroyContext"

    invoke-direct {p0, v0}, Lcom/adobe/air/FlashEGL10;->checkEglError(Ljava/lang/String;)I

    .line 618
    iget-object v0, p0, Lcom/adobe/air/FlashEGL10;->mEgl:Ljavax/microedition/khronos/egl/EGL10;

    iget-object v1, p0, Lcom/adobe/air/FlashEGL10;->mEglDisplay:Ljavax/microedition/khronos/egl/EGLDisplay;

    iget-object v2, p0, Lcom/adobe/air/FlashEGL10;->mEglContext:Ljavax/microedition/khronos/egl/EGLContext;

    invoke-interface {v0, v1, v2}, Ljavax/microedition/khronos/egl/EGL10;->eglDestroyContext(Ljavax/microedition/khronos/egl/EGLDisplay;Ljavax/microedition/khronos/egl/EGLContext;)Z

    .line 619
    const-string v0, "After eglDestroyContext"

    invoke-direct {p0, v0}, Lcom/adobe/air/FlashEGL10;->checkEglError(Ljava/lang/String;)I

    .line 621
    sget-object v0, Ljavax/microedition/khronos/egl/EGL10;->EGL_NO_CONTEXT:Ljavax/microedition/khronos/egl/EGLContext;

    iput-object v0, p0, Lcom/adobe/air/FlashEGL10;->mEglContext:Ljavax/microedition/khronos/egl/EGLContext;

    .line 622
    sget-object v0, Ljavax/microedition/khronos/egl/EGL10;->EGL_NO_SURFACE:Ljavax/microedition/khronos/egl/EGLSurface;

    iput-object v0, p0, Lcom/adobe/air/FlashEGL10;->mEglSurface:Ljavax/microedition/khronos/egl/EGLSurface;

    goto :goto_0

    .line 606
    :catchall_0
    move-exception v0

    :try_start_1
    monitor-exit v1
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    throw v0
.end method

.method public SetConfig(I)V
    .locals 14
    .param p1, "index"    # I

    .prologue
    .line 290
    iget-object v10, p0, Lcom/adobe/air/FlashEGL10;->mEglConfigList:[Ljavax/microedition/khronos/egl/EGLConfig;

    aget-object v10, v10, p1

    iput-object v10, p0, Lcom/adobe/air/FlashEGL10;->mEglConfig:Ljavax/microedition/khronos/egl/EGLConfig;

    .line 292
    const/4 v10, 0x1

    new-array v6, v10, [I

    .line 293
    .local v6, "retVal":[I
    iget-object v10, p0, Lcom/adobe/air/FlashEGL10;->mEgl:Ljavax/microedition/khronos/egl/EGL10;

    iget-object v11, p0, Lcom/adobe/air/FlashEGL10;->mEglDisplay:Ljavax/microedition/khronos/egl/EGLDisplay;

    iget-object v12, p0, Lcom/adobe/air/FlashEGL10;->mEglConfig:Ljavax/microedition/khronos/egl/EGLConfig;

    const/16 v13, 0x3024

    invoke-interface {v10, v11, v12, v13, v6}, Ljavax/microedition/khronos/egl/EGL10;->eglGetConfigAttrib(Ljavax/microedition/khronos/egl/EGLDisplay;Ljavax/microedition/khronos/egl/EGLConfig;I[I)Z

    .line 294
    const/4 v10, 0x0

    aget v5, v6, v10

    .line 295
    .local v5, "red":I
    iget-object v10, p0, Lcom/adobe/air/FlashEGL10;->mEgl:Ljavax/microedition/khronos/egl/EGL10;

    iget-object v11, p0, Lcom/adobe/air/FlashEGL10;->mEglDisplay:Ljavax/microedition/khronos/egl/EGLDisplay;

    iget-object v12, p0, Lcom/adobe/air/FlashEGL10;->mEglConfig:Ljavax/microedition/khronos/egl/EGLConfig;

    const/16 v13, 0x3023

    invoke-interface {v10, v11, v12, v13, v6}, Ljavax/microedition/khronos/egl/EGL10;->eglGetConfigAttrib(Ljavax/microedition/khronos/egl/EGLDisplay;Ljavax/microedition/khronos/egl/EGLConfig;I[I)Z

    .line 296
    const/4 v10, 0x0

    aget v4, v6, v10

    .line 297
    .local v4, "green":I
    iget-object v10, p0, Lcom/adobe/air/FlashEGL10;->mEgl:Ljavax/microedition/khronos/egl/EGL10;

    iget-object v11, p0, Lcom/adobe/air/FlashEGL10;->mEglDisplay:Ljavax/microedition/khronos/egl/EGLDisplay;

    iget-object v12, p0, Lcom/adobe/air/FlashEGL10;->mEglConfig:Ljavax/microedition/khronos/egl/EGLConfig;

    const/16 v13, 0x3022

    invoke-interface {v10, v11, v12, v13, v6}, Ljavax/microedition/khronos/egl/EGL10;->eglGetConfigAttrib(Ljavax/microedition/khronos/egl/EGLDisplay;Ljavax/microedition/khronos/egl/EGLConfig;I[I)Z

    .line 298
    const/4 v10, 0x0

    aget v1, v6, v10

    .line 299
    .local v1, "blue":I
    iget-object v10, p0, Lcom/adobe/air/FlashEGL10;->mEgl:Ljavax/microedition/khronos/egl/EGL10;

    iget-object v11, p0, Lcom/adobe/air/FlashEGL10;->mEglDisplay:Ljavax/microedition/khronos/egl/EGLDisplay;

    iget-object v12, p0, Lcom/adobe/air/FlashEGL10;->mEglConfig:Ljavax/microedition/khronos/egl/EGLConfig;

    const/16 v13, 0x3021

    invoke-interface {v10, v11, v12, v13, v6}, Ljavax/microedition/khronos/egl/EGL10;->eglGetConfigAttrib(Ljavax/microedition/khronos/egl/EGLDisplay;Ljavax/microedition/khronos/egl/EGLConfig;I[I)Z

    .line 300
    const/4 v10, 0x0

    aget v0, v6, v10

    .line 301
    .local v0, "alpha":I
    iget-object v10, p0, Lcom/adobe/air/FlashEGL10;->mEgl:Ljavax/microedition/khronos/egl/EGL10;

    iget-object v11, p0, Lcom/adobe/air/FlashEGL10;->mEglDisplay:Ljavax/microedition/khronos/egl/EGLDisplay;

    iget-object v12, p0, Lcom/adobe/air/FlashEGL10;->mEglConfig:Ljavax/microedition/khronos/egl/EGLConfig;

    const/16 v13, 0x3025

    invoke-interface {v10, v11, v12, v13, v6}, Ljavax/microedition/khronos/egl/EGL10;->eglGetConfigAttrib(Ljavax/microedition/khronos/egl/EGLDisplay;Ljavax/microedition/khronos/egl/EGLConfig;I[I)Z

    .line 302
    const/4 v10, 0x0

    aget v3, v6, v10

    .line 303
    .local v3, "depth":I
    iget-object v10, p0, Lcom/adobe/air/FlashEGL10;->mEgl:Ljavax/microedition/khronos/egl/EGL10;

    iget-object v11, p0, Lcom/adobe/air/FlashEGL10;->mEglDisplay:Ljavax/microedition/khronos/egl/EGLDisplay;

    iget-object v12, p0, Lcom/adobe/air/FlashEGL10;->mEglConfig:Ljavax/microedition/khronos/egl/EGLConfig;

    const/16 v13, 0x3026

    invoke-interface {v10, v11, v12, v13, v6}, Ljavax/microedition/khronos/egl/EGL10;->eglGetConfigAttrib(Ljavax/microedition/khronos/egl/EGLDisplay;Ljavax/microedition/khronos/egl/EGLConfig;I[I)Z

    .line 304
    const/4 v10, 0x0

    aget v8, v6, v10

    .line 305
    .local v8, "stencil":I
    iget-object v10, p0, Lcom/adobe/air/FlashEGL10;->mEgl:Ljavax/microedition/khronos/egl/EGL10;

    iget-object v11, p0, Lcom/adobe/air/FlashEGL10;->mEglDisplay:Ljavax/microedition/khronos/egl/EGLDisplay;

    iget-object v12, p0, Lcom/adobe/air/FlashEGL10;->mEglConfig:Ljavax/microedition/khronos/egl/EGLConfig;

    const/16 v13, 0x3031

    invoke-interface {v10, v11, v12, v13, v6}, Ljavax/microedition/khronos/egl/EGL10;->eglGetConfigAttrib(Ljavax/microedition/khronos/egl/EGLDisplay;Ljavax/microedition/khronos/egl/EGLConfig;I[I)Z

    .line 306
    const/4 v10, 0x0

    aget v7, v6, v10

    .line 307
    .local v7, "samples":I
    iget-object v10, p0, Lcom/adobe/air/FlashEGL10;->mEgl:Ljavax/microedition/khronos/egl/EGL10;

    iget-object v11, p0, Lcom/adobe/air/FlashEGL10;->mEglDisplay:Ljavax/microedition/khronos/egl/EGLDisplay;

    iget-object v12, p0, Lcom/adobe/air/FlashEGL10;->mEglConfig:Ljavax/microedition/khronos/egl/EGLConfig;

    const/16 v13, 0x3032

    invoke-interface {v10, v11, v12, v13, v6}, Ljavax/microedition/khronos/egl/EGL10;->eglGetConfigAttrib(Ljavax/microedition/khronos/egl/EGLDisplay;Ljavax/microedition/khronos/egl/EGLConfig;I[I)Z

    .line 308
    const/4 v10, 0x0

    aget v2, v6, v10

    .line 309
    .local v2, "buffers":I
    iget-object v10, p0, Lcom/adobe/air/FlashEGL10;->mEgl:Ljavax/microedition/khronos/egl/EGL10;

    iget-object v11, p0, Lcom/adobe/air/FlashEGL10;->mEglDisplay:Ljavax/microedition/khronos/egl/EGLDisplay;

    iget-object v12, p0, Lcom/adobe/air/FlashEGL10;->mEglConfig:Ljavax/microedition/khronos/egl/EGLConfig;

    const/16 v13, 0x3033

    invoke-interface {v10, v11, v12, v13, v6}, Ljavax/microedition/khronos/egl/EGL10;->eglGetConfigAttrib(Ljavax/microedition/khronos/egl/EGLDisplay;Ljavax/microedition/khronos/egl/EGLConfig;I[I)Z

    .line 310
    const/4 v10, 0x0

    aget v9, v6, v10

    .line 313
    .local v9, "surface":I
    return-void
.end method

.method public SwapEGLBuffers()V
    .locals 3

    .prologue
    .line 631
    const/16 v0, 0x3000

    invoke-virtual {p0}, Lcom/adobe/air/FlashEGL10;->MakeGLCurrent()I

    move-result v1

    if-eq v0, v1, :cond_0

    .line 638
    :goto_0
    return-void

    .line 635
    :cond_0
    const-string v0, "Before eglSwapBuffers"

    invoke-direct {p0, v0}, Lcom/adobe/air/FlashEGL10;->checkEglError(Ljava/lang/String;)I

    .line 636
    iget-object v0, p0, Lcom/adobe/air/FlashEGL10;->mEgl:Ljavax/microedition/khronos/egl/EGL10;

    iget-object v1, p0, Lcom/adobe/air/FlashEGL10;->mEglDisplay:Ljavax/microedition/khronos/egl/EGLDisplay;

    iget-object v2, p0, Lcom/adobe/air/FlashEGL10;->mEglSurface:Ljavax/microedition/khronos/egl/EGLSurface;

    invoke-interface {v0, v1, v2}, Ljavax/microedition/khronos/egl/EGL10;->eglSwapBuffers(Ljavax/microedition/khronos/egl/EGLDisplay;Ljavax/microedition/khronos/egl/EGLSurface;)Z

    .line 637
    const-string v0, "After eglSwapBuffers"

    invoke-direct {p0, v0}, Lcom/adobe/air/FlashEGL10;->checkEglError(Ljava/lang/String;)I

    goto :goto_0
.end method

.method public TerminateEGL()V
    .locals 2

    .prologue
    .line 574
    iget-object v0, p0, Lcom/adobe/air/FlashEGL10;->mEgl:Ljavax/microedition/khronos/egl/EGL10;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/adobe/air/FlashEGL10;->mEglDisplay:Ljavax/microedition/khronos/egl/EGLDisplay;

    sget-object v1, Ljavax/microedition/khronos/egl/EGL10;->EGL_NO_DISPLAY:Ljavax/microedition/khronos/egl/EGLDisplay;

    if-eq v0, v1, :cond_0

    .line 577
    iget-object v0, p0, Lcom/adobe/air/FlashEGL10;->mEgl:Ljavax/microedition/khronos/egl/EGL10;

    iget-object v1, p0, Lcom/adobe/air/FlashEGL10;->mEglDisplay:Ljavax/microedition/khronos/egl/EGLDisplay;

    invoke-interface {v0, v1}, Ljavax/microedition/khronos/egl/EGL10;->eglTerminate(Ljavax/microedition/khronos/egl/EGLDisplay;)Z

    .line 579
    :cond_0
    sget-object v0, Ljavax/microedition/khronos/egl/EGL10;->EGL_NO_DISPLAY:Ljavax/microedition/khronos/egl/EGLDisplay;

    iput-object v0, p0, Lcom/adobe/air/FlashEGL10;->mEglDisplay:Ljavax/microedition/khronos/egl/EGLDisplay;

    .line 580
    return-void
.end method
