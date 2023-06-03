.class public Lair/extensions/VibrationSupportedFunction;
.super Ljava/lang/Object;
.source "VibrationSupportedFunction.java"

# interfaces
.implements Lcom/adobe/fre/FREFunction;


# direct methods
.method public constructor <init>()V
    .locals 0

    .prologue
    .line 25
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public call(Lcom/adobe/fre/FREContext;[Lcom/adobe/fre/FREObject;)Lcom/adobe/fre/FREObject;
    .locals 5
    .param p1, "context"    # Lcom/adobe/fre/FREContext;
    .param p2, "passedArgs"    # [Lcom/adobe/fre/FREObject;

    .prologue
    .line 30
    const/4 v1, 0x0

    .line 32
    .local v1, "result":Lcom/adobe/fre/FREObject;
    const-string v3, "VibrationSupportedFunction"

    const-string v4, "call"

    invoke-static {v3, v4}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    move-object v2, p1

    .line 34
    check-cast v2, Lair/extensions/VibrationExtensionContext;

    .line 38
    .local v2, "vibExtContext":Lair/extensions/VibrationExtensionContext;
    :try_start_0
    iget-object v3, v2, Lair/extensions/VibrationExtensionContext;->androidVibrator:Landroid/os/Vibrator;

    if-nez v3, :cond_0

    .line 41
    const-string v3, "VibrationSupportedFunction"

    const-string v4, "NOT supported"

    invoke-static {v3, v4}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 42
    const/4 v3, 0x0

    invoke-static {v3}, Lcom/adobe/fre/FREObject;->newObject(Z)Lcom/adobe/fre/FREObject;

    move-result-object v1

    .line 59
    :goto_0
    return-object v1

    .line 48
    :cond_0
    const-string v3, "VibrationSupportedFunction"

    const-string v4, "Supported"

    invoke-static {v3, v4}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 49
    const/4 v3, 0x1

    invoke-static {v3}, Lcom/adobe/fre/FREObject;->newObject(Z)Lcom/adobe/fre/FREObject;
    :try_end_0
    .catch Lcom/adobe/fre/FREWrongThreadException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v1

    goto :goto_0

    .line 54
    :catch_0
    move-exception v0

    .line 56
    .local v0, "e":Lcom/adobe/fre/FREWrongThreadException;
    invoke-virtual {v0}, Lcom/adobe/fre/FREWrongThreadException;->printStackTrace()V

    goto :goto_0
.end method
