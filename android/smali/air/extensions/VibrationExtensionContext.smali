.class public Lair/extensions/VibrationExtensionContext;
.super Lcom/adobe/fre/FREContext;
.source "VibrationExtensionContext.java"


# instance fields
.field public androidVibrator:Landroid/os/Vibrator;


# direct methods
.method public constructor <init>()V
    .locals 2

    .prologue
    .line 29
    invoke-direct {p0}, Lcom/adobe/fre/FREContext;-><init>()V

    .line 27
    const/4 v0, 0x0

    iput-object v0, p0, Lair/extensions/VibrationExtensionContext;->androidVibrator:Landroid/os/Vibrator;

    .line 32
    const-string v0, "VibrationExtensionContext"

    const-string v1, "constructor"

    invoke-static {v0, v1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 34
    return-void
.end method


# virtual methods
.method public dispose()V
    .locals 2

    .prologue
    .line 42
    const-string v0, "VibrationExtensionContext"

    const-string v1, "dispose"

    invoke-static {v0, v1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 44
    const/4 v0, 0x0

    iput-object v0, p0, Lair/extensions/VibrationExtensionContext;->androidVibrator:Landroid/os/Vibrator;

    .line 45
    return-void
.end method

.method public getFunctions()Ljava/util/Map;
    .locals 3
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/Map",
            "<",
            "Ljava/lang/String;",
            "Lcom/adobe/fre/FREFunction;",
            ">;"
        }
    .end annotation

    .prologue
    .line 54
    const-string v1, "VibrationExtensionContext"

    const-string v2, "getFunctions"

    invoke-static {v1, v2}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 56
    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    .line 58
    .local v0, "functionMap":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Lcom/adobe/fre/FREFunction;>;"
    const-string v1, "isSupported"

    new-instance v2, Lair/extensions/VibrationSupportedFunction;

    invoke-direct {v2}, Lair/extensions/VibrationSupportedFunction;-><init>()V

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 59
    const-string v1, "vibrateDevice"

    new-instance v2, Lair/extensions/VibrationVibrateFunction;

    invoke-direct {v2}, Lair/extensions/VibrationVibrateFunction;-><init>()V

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 60
    const-string v1, "initNativeCode"

    new-instance v2, Lair/extensions/VibrationInitNativeCodeFunction;

    invoke-direct {v2}, Lair/extensions/VibrationInitNativeCodeFunction;-><init>()V

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 63
    return-object v0
.end method
