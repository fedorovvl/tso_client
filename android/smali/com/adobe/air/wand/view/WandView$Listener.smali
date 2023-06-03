.class public interface abstract Lcom/adobe/air/wand/view/WandView$Listener;
.super Ljava/lang/Object;
.source "WandView.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/adobe/air/wand/view/WandView;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x609
    name = "Listener"
.end annotation


# virtual methods
.method public abstract getConnectionToken()Ljava/lang/String;
.end method

.method public abstract onLoadCompanion(Landroid/content/res/Configuration;)V
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation
.end method
