.class public interface abstract Lcom/adobe/air/wand/view/WandView;
.super Ljava/lang/Object;
.source "WandView.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/adobe/air/wand/view/WandView$Listener;,
        Lcom/adobe/air/wand/view/WandView$ScreenOrientation;
    }
.end annotation


# virtual methods
.method public abstract drawImage(Landroid/graphics/Bitmap;)V
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation
.end method

.method public abstract getTouchSensor()Lcom/adobe/air/wand/view/TouchSensor;
.end method

.method public abstract loadCompanionView()V
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation
.end method

.method public abstract loadDefaultView()V
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation
.end method

.method public abstract registerListener(Lcom/adobe/air/wand/view/WandView$Listener;)V
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation
.end method

.method public abstract setScreenOrientation(Lcom/adobe/air/wand/view/WandView$ScreenOrientation;)V
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation
.end method

.method public abstract unregisterListener()V
.end method

.method public abstract updateConnectionToken(Ljava/lang/String;)V
.end method
